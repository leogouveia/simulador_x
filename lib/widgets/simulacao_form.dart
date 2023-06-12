import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simulador_x/models/simulacao_dados.dart';
import 'package:simulador_x/providers/app_provider.dart';
import 'package:simulador_x/screens/simulacao_loading_screen.dart';
import 'package:simulador_x/theme/app_colors.dart';

class SimulacaoForm extends ConsumerStatefulWidget {
  const SimulacaoForm({Key? key}) : super(key: key);

  @override
  ConsumerState<SimulacaoForm> createState() => _SimulacaoFormState();
}

class _SimulacaoFormState extends ConsumerState<SimulacaoForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _prazoController = TextEditingController();

  NavigatorState? _navigator;

  String result = '';
  SimulacaoDados? simulationResult;

  @override
  void dispose() {
    _valueController.dispose();
    _prazoController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      simulate();
    }
  }

  Future<void> simulate() async {
    final valorDesejado = double.tryParse(
          _valueController.text.replaceAll('.', '').replaceAll(',', '.'),
        ) ??
        0;
    final prazo = int.tryParse(_prazoController.text) ?? 0;

    ref.read(appProvider.notifier).setSimulacao(valorDesejado, prazo);

    _navigator?.push(MaterialPageRoute(
        builder: (context) => const SimulacaoLoadingScreen()));

    _valueController.clear();
    _prazoController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _navigator = Navigator.of(context);
    final nomeUsuario = ref.watch(appProvider).nomeUsuario;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(6.0),
            color: AppColors.cinzaLighter1,
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${nomeUsuario.isNotEmpty ? nomeUsuario : 'Usuário'}, ",
                          style: Theme.of(context).textTheme.displayMedium),
                      Text("Informe os valores para simulação",
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _valueController,
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
                        textInputAction: TextInputAction
                            .next, // Display "next" arrow on the keyboard
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _prazoController,
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
                        onFieldSubmitted: (value) {
                          _submitForm();
                        },
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: FilledButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                            ),
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          onPressed: _submitForm,
                          child: Text('Simular'.toUpperCase()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
