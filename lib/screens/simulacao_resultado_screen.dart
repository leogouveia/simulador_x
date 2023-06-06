import 'package:flutter/material.dart';
import 'package:simulador_x/components/simulacao_resultado.dart';
import 'package:simulador_x/layouts/app_bar.dart';
import 'package:simulador_x/models/simulacao_dados.dart';
import 'package:simulador_x/screens/simulacao_resultado_modalidade_screen.dart';

import '../layouts/my-button.dart';

class SimulacaoResultScreen extends StatelessWidget {
  final SimulacaoDados? simulacaoDados;
  final double valor;
  final int prazo;

  const SimulacaoResultScreen(
      {Key? key, this.simulacaoDados, required this.valor, required this.prazo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Resultado'),
      body: ListView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          SimulacaoResultado(
              valor: valor, prazo: prazo, simulacaoDados: simulacaoDados),
          const SizedBox(height: 16.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                buttonText: 'Veja PRICE',
                onTap: () {
                  final List<Parcela>? parcelasPrice = simulacaoDados
                      ?.resultadoSimulacao
                      .firstWhere((e) => e.tipo.toLowerCase() == 'price')
                      ?.parcelas;

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SimulacaoResultadoModalidade(
                        nomeModalidade: 'Price',
                        parcelas: parcelasPrice ?? [],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              MyButton(
                buttonText: 'Veja SAC',
                onTap: () {
                  final List<Parcela>? parcelasSac = simulacaoDados
                      ?.resultadoSimulacao
                      .firstWhere((e) => e.tipo.toLowerCase() == 'sac')
                      ?.parcelas;

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SimulacaoResultadoModalidade(
                        nomeModalidade: 'Sac',
                        parcelas: parcelasSac ?? [],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
