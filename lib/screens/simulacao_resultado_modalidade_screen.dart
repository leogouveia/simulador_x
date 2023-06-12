import 'package:flutter/material.dart';
import 'package:simulador_x/models/simulacao_dados.dart';
import 'package:simulador_x/widgets/layouts/app_bar.dart';
import 'package:simulador_x/widgets/simulacao_tabela.dart';

class SimulacaoResultadoModalidade extends StatelessWidget {
  final String nomeModalidade;
  final List<Parcela> parcelas;
  const SimulacaoResultadoModalidade(
      {super.key, required this.nomeModalidade, required this.parcelas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(title: nomeModalidade.toUpperCase()),
      body: SimulacaoTabela(
        parcelas: parcelas,
        nomeModalidade: nomeModalidade,
      ),
    );
  }
}
