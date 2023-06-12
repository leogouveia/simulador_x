import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simulador_x/models/dados_chart.model.dart';
import 'package:simulador_x/models/simulacao_dados.dart';
import 'package:simulador_x/screens/simulacao_resultado_modalidade_screen.dart';
import 'package:simulador_x/widgets/simulacao_resultado_chart.dart';

import '../theme/app_colors.dart';

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
    final valoresSac = simulacaoDados?.resultadoSimulacao
        .where((r) => r.tipo.toLowerCase() == 'sac')
        .first;
    final valoresPrice = simulacaoDados?.resultadoSimulacao
        .where((r) => r.tipo.toLowerCase() == 'price')
        .first;

    final valorParcelaPrice =
        valoresPrice?.parcelas.first.valorPrestacao ?? 0.00;

    final valorPrimeiraParcelaSac =
        valoresSac?.parcelas.first.valorPrestacao ?? 0.00;
    final valorUltimaParcelaSac =
        valoresSac?.parcelas.last.valorPrestacao ?? 0.00;

    final valorTotalJurosPrice = valoresPrice?.parcelas
            .fold<double>(0.00, (acum, item) => acum + item.valorJuros) ??
        0.00;

    final valorTotalAmortizacaoPrice = valoresPrice?.parcelas
            .fold<double>(0.00, (acum, item) => acum + item.valorAmortizacao) ??
        0.00;

    return SingleChildScrollView(
      child: Column(
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(6.0),
            color: AppColors.azulLighter1,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
              child: Column(
                children: [
                  Row(children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: FittedBox(
                        child: Column(
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
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      flex: 1,
                      child: FittedBox(
                        child: Column(
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
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                        flex: 1,
                        child: FittedBox(
                          child: Column(
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
                          ),
                        )),
                  ]),
                  const SizedBox(height: 10.0),
                  const Divider(color: AppColors.azulLighter2),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(children: [
                          const Text("SAC",
                              style: TextStyle(
                                color: AppColors.cinzaLighter2,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              )),
                          FittedBox(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Valor 1ª Parcela",
                                      style: TextStyle(
                                        color: AppColors.cinzaLighter2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      "R\$ ${numberFormat.format(valorPrimeiraParcelaSac)} ",
                                      style: const TextStyle(
                                        color: AppColors.cinzaLighter2,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Valor Ultima Parcela",
                                      style: TextStyle(
                                        color: AppColors.cinzaLighter2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      "R\$ ${numberFormat.format(valorUltimaParcelaSac)} ",
                                      style: const TextStyle(
                                        color: AppColors.cinzaLighter2,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ]),
                      ),
                      const SizedBox(width: 16.0),
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            const Text("PRICE",
                                style: TextStyle(
                                  color: AppColors.cinzaLighter2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                )),
                            FittedBox(
                              child: Row(
                                children: [
                                  const Text(
                                    "Valor Parcela",
                                    style: TextStyle(
                                      color: AppColors.cinzaLighter2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    "R\$ ${numberFormat.format(valorParcelaPrice)} ",
                                    style: const TextStyle(
                                      color: AppColors.cinzaLighter2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          const SizedBox(height: 16.0),
          Material(
            borderRadius: BorderRadius.circular(6.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SimulacaoResultadoChart(
                data: [
                  DadosChart("Juros", valorTotalJurosPrice,
                      "R\$ ${numberFormat.format(valorTotalJurosPrice)}"),
                  DadosChart("Amortizacao", valorTotalAmortizacaoPrice,
                      "R\$  ${numberFormat.format(valorTotalAmortizacaoPrice)}"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: FilledButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onPressed: () {
                    final List<Parcela>? parcelasPrice = simulacaoDados
                        ?.resultadoSimulacao
                        .firstWhere((e) => e.tipo.toLowerCase() == 'price')
                        .parcelas;

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SimulacaoResultadoModalidade(
                          nomeModalidade: 'Price',
                          parcelas: parcelasPrice ?? [],
                        ),
                      ),
                    );
                  },
                  child: const Text('Veja PRICE'),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                flex: 1,
                child: FilledButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onPressed: () {
                    final List<Parcela>? parcelasSac = simulacaoDados
                        ?.resultadoSimulacao
                        .firstWhere((e) => e.tipo.toLowerCase() == 'sac')
                        .parcelas;

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SimulacaoResultadoModalidade(
                          nomeModalidade: 'Sac',
                          parcelas: parcelasSac ?? [],
                        ),
                      ),
                    );
                  },
                  child: const Text('Veja SAC'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
