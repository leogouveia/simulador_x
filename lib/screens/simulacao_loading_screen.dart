import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simulador_x/layouts/app_bar.dart';
import 'package:simulador_x/models/simulacao_dados.dart';
import 'package:simulador_x/models/warning_model.dart';
import 'package:simulador_x/providers/app_provider.dart';
import 'package:simulador_x/screens/simulacao_resultado_screen.dart';
import 'package:simulador_x/services/fetch_simulacao.dart';
import 'package:simulador_x/components/warning.dart' as WarningWidget;

class SimulacaoLoadingScreen extends ConsumerStatefulWidget {
  const SimulacaoLoadingScreen({Key? key, this.vocalSpeak, this.vocal = false})
      : super(key: key);

  final Future<void> Function(String text)? vocalSpeak;
  final bool vocal;
  @override
  _SimulacaoLoadingScreenState createState() => _SimulacaoLoadingScreenState();
}

class _SimulacaoLoadingScreenState
    extends ConsumerState<SimulacaoLoadingScreen> {
  late Future<(SimulacaoDados?, Warning?)> _fetchSimulacaoFuture;

  @override
  void initState() {
    super.initState();
    final simulacaoDados = ref.read(appProvider);
    _fetchSimulacaoFuture =
        fetchSimulacao(simulacaoDados.valorDesejado, simulacaoDados.valorPrazo);
  }

  Future<(SimulacaoDados?, Warning?)> fetchSimulacao(
      double valorDesejado, int valorPrazo) async {
    SimulacaoDados? dadosSimulacao;
    Warning? warning;

    final result = await FetchSimulacao.getSimulacao(valorDesejado, valorPrazo);
    result.fold((SimulacaoDados? dadosSimulacaoResult) {
      dadosSimulacao = dadosSimulacaoResult;
    }, (Warning? warningResult) {
      warning = warningResult;
    });

    await Future.delayed(const Duration(seconds: 2));
    return (dadosSimulacao, warning);
  }

  @override
  Widget build(BuildContext context) {
    final simulacaoForm = ref.watch(appProvider);

    return Scaffold(
      appBar: const MyAppBar(title: 'Simulador Caixa'),
      body: FutureBuilder<(SimulacaoDados?, Warning?)>(
          future: _fetchSimulacaoFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final (data, warning) = snapshot.data!;
              if (warning != null) {
                if (widget.vocal) {
                  widget.vocalSpeak!("Atenção, ${warning.mensagem}.");
                }
                return Center(
                  child: WarningWidget.Warning(
                    warningText: warning.mensagem,
                  ),
                );
              }

              if (widget.vocal) {
                widget.vocalSpeak!("Simulação realizada com sucesso.");
              }

              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return SimulacaoResultScreen(
                    prazo: simulacaoForm.valorPrazo,
                    valor: simulacaoForm.valorDesejado,
                    simulacaoDados: data,
                  );
                }));
              });
              return Container();
            }
            if (snapshot.hasError) {
              var mensagem = 'Houve um problema na simulação.';
              if (widget.vocal) {
                widget.vocalSpeak!(mensagem);
              }

              return Center(
                child: WarningWidget.Warning(
                  warningText: mensagem,
                ),
              );
            }
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Carregando...'),
                ],
              ),
            );
          }),
    );
  }
}
