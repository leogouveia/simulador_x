import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simulador_x/models/simulacao_dados.dart';

class SimulacaoTabela extends StatelessWidget {
  final List<Parcela> parcelas;
  final String nomeModalidade;
  const SimulacaoTabela(
      {Key? key, required this.parcelas, required this.nomeModalidade})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Text(
            "Modalidade $nomeModalidade",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: parcelas.length,
              itemBuilder: (context, index) {
                Parcela parcela = parcelas[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text('Parcela: ${parcela.numero}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Valor Amortização: ${f.format(parcela.valorAmortizacao)}',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          Text('Valor Juros: ${f.format(parcela.valorJuros)}',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                          Text(
                              'Valor Prestação: ${f.format(parcela.valorPrestacao)}',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
