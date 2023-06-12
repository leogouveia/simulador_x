import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simulador_x/models/simulacao_dados.dart';
import 'package:simulador_x/providers/app_provider.dart';
import 'package:simulador_x/screens/simulacao_loading_screen.dart';
import 'package:simulador_x/theme/app_colors.dart';

class SimuladorForm extends ConsumerStatefulWidget {
  const SimuladorForm({Key? key}) : super(key: key);

  @override
  ConsumerState<SimuladorForm> createState() => _SimuladorFormState();
}

class _SimuladorFormState extends ConsumerState<SimuladorForm> {
  TextEditingController valueController = TextEditingController();
  TextEditingController prazoController = TextEditingController();

  NavigatorState? _navigator;

  String result = '';
  SimulacaoDados? simulationResult;

  Future<void> simulate() async {
    final valorDesejado = double.tryParse(
          valueController.text.replaceAll('.', '').replaceAll(',', '.'),
        ) ??
        0;
    final prazo = int.tryParse(prazoController.text) ?? 0;

    ref.read(appProvider.notifier).setSimulacao(valorDesejado, prazo);

    _navigator?.push(
        MaterialPageRoute(builder: (context) => SimulacaoLoadingScreen()));

    valueController.clear();
    prazoController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _navigator = Navigator.of(context);
    final formKey = GlobalKey<FormState>();
    return Center(
      child: IntrinsicHeight(
        child: Container(
          width: 400,
          decoration: BoxDecoration(
            color: AppColors.cinzaLighter1,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
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
                      if (double.tryParse(numberValue) == null) {
                        return 'Preencha com um número';
                      }
                      return null;
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
                      if (double.tryParse(value) == null) {
                        return 'Preencha com um número';
                      }
                      return null;
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
                      if (formKey.currentState!.validate()) {
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
