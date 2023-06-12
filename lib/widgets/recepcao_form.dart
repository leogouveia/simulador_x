import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simulador_x/providers/app_provider.dart';

class RecepcaoForm extends ConsumerStatefulWidget {
  const RecepcaoForm({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  ConsumerState<RecepcaoForm> createState() => _RecepcaoFormState();
}

class _RecepcaoFormState extends ConsumerState<RecepcaoForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  void _submitForm() {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      final nomeUsuario = _nomeController.text;
      ref.read(appProvider.notifier).setNomeUsuario(nomeUsuario);
      if (widget.onPressed != null) {
        widget.onPressed!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu nome';
                }
                return null;
              },
              onFieldSubmitted: (value) {
                _submitForm();
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
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
              onPressed: _submitForm,
              child: const Text("Continuar"),
            ),
          ),
        ],
      ),
    );
  }
}
