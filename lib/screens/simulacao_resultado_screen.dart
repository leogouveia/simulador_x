import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simulador_x/providers/app_provider.dart';
import 'package:simulador_x/providers/resultado_simulacao_provider.dart';
import 'package:simulador_x/widgets/app_scaffold.dart';
import 'package:simulador_x/widgets/simulacao_resultado.dart';

class SimulacaoResultScreen extends ConsumerWidget {
  const SimulacaoResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultadoSimulacao = ref.watch(resultadoSimulacaoProvider);
    final dadosSimulacao = ref.watch(appProvider);
    return AppScaffold(
      appBarTitle: 'Resultado',
      centerList: false,
      body: ListView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          SimulacaoResultado(
              valor: dadosSimulacao.valorDesejado,
              prazo: dadosSimulacao.valorPrazo,
              simulacaoDados: resultadoSimulacao),
        ],
      ),
    );
  }
}
