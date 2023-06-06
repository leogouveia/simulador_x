import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simulador_x/models/simulacao_dados.dart';
import 'package:simulador_x/utils/x-colors.dart';

class SimulacaoResultado extends StatelessWidget {
  final SimulacaoDados? simulacaoDados;
  final int prazo;
  final double valor;

  const SimulacaoResultado(
      {super.key,
      this.simulacaoDados,
      required this.valor,
      required this.prazo});

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat("#,###.00", 'pt_BR');

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kxColors.azul.standard,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Text(
                      "Valor",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text("R\$ ${numberFormat.format(valor)} "),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Text(
                      "Prazo",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(prazo.toString()),
                  ],
                ),
              ],
            ),
            VerticalDivider(
              color: kxColors.azul.lighter_1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Descricao Produto',
                  style: TextStyle(
                    color: kxColors.cinza.lighter_2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  simulacaoDados?.descricaoProduto ?? "",
                  style: TextStyle(
                    color: kxColors.cinza.lighter_2,
                  ),
                ),
              ],
            ),
            VerticalDivider(
              color: kxColors.azul.lighter_1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Taxa de Juros',
                  style: TextStyle(
                    color: kxColors.cinza.lighter_2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "${((simulacaoDados?.taxaJuros ?? 0.0) * 100)?.toStringAsFixed(2) ?? 0}%",
                  style: TextStyle(
                    color: kxColors.cinza.lighter_2,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
