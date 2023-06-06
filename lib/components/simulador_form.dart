import 'package:flutter/material.dart';
import 'package:simulador_x/models/simulacao_dados.dart';
import 'package:simulador_x/models/warning_model.dart';
import 'package:simulador_x/screens/simulacao_resultado_screen.dart';
import 'package:simulador_x/services/fetch_simulacao.dart';
import 'package:simulador_x/utils/x-colors.dart';

class SimuladorForm extends StatefulWidget {
  const SimuladorForm({Key? key}) : super(key: key);

  @override
  State<SimuladorForm> createState() => _SimuladorFormState();
}

class _SimuladorFormState extends State<SimuladorForm> {
  TextEditingController valueController = TextEditingController();
  TextEditingController prazoController = TextEditingController();

  String result = '';
  SimulacaoDados? simulationResult;

  Future<void> simulate() async {
    final navigator = Navigator.of(context);
    SimulacaoDados? dadosSimulacao;
    Warning? warning;

    var numberValue =
        valueController.text.replaceAll('.', '').replaceAll(',', '.');
    double value = double.tryParse(numberValue) ?? 0.0;
    int prazo = int.tryParse(prazoController.text) ?? 0;

    final result = await FetchSimulacao.getSimulacao(value, prazo);
    result.fold((SimulacaoDados? dadosSimulacaoResult) {
      dadosSimulacao = dadosSimulacaoResult;
    }, (Warning? warningResult) {
      warning = warningResult;
    });

    if (dadosSimulacao != null) {
      navigator.push(MaterialPageRoute(builder: (context) {
        return SimulacaoResultScreen(
          simulacaoDados: dadosSimulacao,
          valor: value,
          prazo: prazo,
        );
      }));
    } else {
      String mensagem = 'Houve um problema na simulação.';
      if (warning != null && warning!.mensagem != "") {
        mensagem = warning!.mensagem;
      }
      _showWarning(mensagem);
    }

    valueController.clear();
    prazoController.clear();
    setState(() {});
  }

  Future<void> _showWarning(String warningText) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(warningText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Center(
      child: IntrinsicHeight(
        child: Container(
          width: 400,
          decoration: BoxDecoration(
            color: kxColors.cinza.lighter_1,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Informe os valores para simulação",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: valueController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      //if value is nto a number/numeric
                      var numberValue =
                          value.replaceAll('.', '').replaceAll(',', '.');
                      if (double.tryParse(numberValue!) == null) {
                        return 'Preencha com um número';
                      }
                    },
                    decoration: const InputDecoration(
                      label: Text("Valor desejado"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: prazoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      //if value is nto a number/numeric
                      if (double.tryParse(value!) == null) {
                        return 'Preencha com um número';
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Prazo (meses)"),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
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
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Processando solicitação')),
                        );
                        simulate();
                      }
                    },
                    child: Text('Simular'.toUpperCase()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
