import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simulador_x/models/simulacao_dados.dart';
import 'package:simulador_x/models/warning_model.dart';
import 'package:simulador_x/providers/app_provider.dart';
import 'package:simulador_x/providers/resultado_simulacao_provider.dart';
import 'package:simulador_x/services/fetch_simulacao.dart';
import 'package:simulador_x/theme/app_colors.dart';
import 'package:simulador_x/widgets/app_scaffold.dart';
import 'package:simulador_x/widgets/warning.dart' as warning_widget;

class SimulacaoLoadingScreen extends ConsumerStatefulWidget {
  const SimulacaoLoadingScreen({Key? key, this.vocalSpeak, this.vocal = false})
      : super(key: key);

  final Future<void> Function(String text)? vocalSpeak;
  final bool vocal;
  @override
  createState() => _SimulacaoLoadingScreenState();
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

    final setSimulacaoDados =
        ref.read(resultadoSimulacaoProvider.notifier).setResultado;
    if (dadosSimulacao != null) {
      setSimulacaoDados(dadosSimulacao!);
    }
    // await Future.delayed(const Duration(seconds: 60));

    return (dadosSimulacao, warning);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: FutureBuilder<(SimulacaoDados?, Warning?)>(
          future: _fetchSimulacaoFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final (_, warning) = snapshot.data!;
              if (warning != null) {
                if (widget.vocal) {
                  widget.vocalSpeak!("Atenção, ${warning.mensagem}.");
                }
                return Center(
                  child: warning_widget.Warning(
                    warningText: warning.mensagem,
                  ),
                );
              }

              if (widget.vocal) {
                widget.vocalSpeak!("Simulação realizada com sucesso.");
              }

              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).popAndPushNamed('/resultado_simulacao');
                // Navigator.of(context).pop();
                // Navigator.of(context).push(route);
              });
              return Container();
            }
            if (snapshot.hasError) {
              var mensagem = 'Houve um problema na simulação.';
              if (widget.vocal) {
                widget.vocalSpeak!(mensagem);
              }

              return Center(
                child: warning_widget.Warning(
                  warningText: mensagem,
                ),
              );
            }
            return Center(
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(6.0),
                color: AppColors.cinzaLighter1,
                child: const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text('Carregando...'),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
