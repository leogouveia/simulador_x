import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simulador_x/models/simulacao_dados.dart';
import 'package:simulador_x/theme/app_colors.dart';

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
        color: AppColors.azul,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        child: FittedBox(
          fit: BoxFit.scaleDown,
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
                          color: AppColors.cinzaLighter2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        "R\$ ${numberFormat.format(valor)} ",
                        style: const TextStyle(
                          color: AppColors.cinzaLighter2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Text(
                        "Prazo",
                        style: TextStyle(
                          color: AppColors.cinzaLighter2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        prazo.toString(),
                        style: const TextStyle(
                          color: AppColors.cinzaLighter2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const VerticalDivider(
                color: AppColors.azulLighter1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Descricao Produto',
                    style: TextStyle(
                      color: AppColors.cinzaLighter2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    simulacaoDados?.descricaoProduto ?? "",
                    style: const TextStyle(
                      color: AppColors.cinzaLighter2,
                    ),
                  ),
                ],
              ),
              const VerticalDivider(
                color: AppColors.azulLighter1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Taxa de Juros',
                    style: TextStyle(
                      color: AppColors.cinzaLighter2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "${((simulacaoDados?.taxaJuros ?? 0.0) * 100).toStringAsFixed(2)}%",
                    style: const TextStyle(
                      color: AppColors.cinzaLighter2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
