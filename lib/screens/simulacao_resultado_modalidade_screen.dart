import 'package:flutter/material.dart';
import 'package:simulador_x/components/simulacao_tabela.dart';
import 'package:simulador_x/layouts/app_bar.dart';
import 'package:simulador_x/models/simulacao_dados.dart';

class SimulacaoResultadoModalidade extends StatelessWidget {
  final String nomeModalidade;
  List<Parcela> parcelas = [];
  SimulacaoResultadoModalidade(
      {super.key, required this.nomeModalidade, required this.parcelas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: nomeModalidade.toUpperCase()),
      body: SimulacaoTabela(
        parcelas: parcelas,
        nomeModalidade: nomeModalidade,
      ),
    );
  }
}
