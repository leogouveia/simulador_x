import 'package:flutter/material.dart';
import 'package:simulador_x/widgets/app_scaffold.dart';
import 'package:simulador_x/widgets/simulacao_form.dart';
import 'package:simulador_x/widgets/simulacao_vocal.dart';

class SimulacaoFormScreen extends StatefulWidget {
  const SimulacaoFormScreen({super.key});

  @override
  State<SimulacaoFormScreen> createState() => _SimulacaoFormScreenState();
}

class _SimulacaoFormScreenState extends State<SimulacaoFormScreen> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SimulacaoForm(),
          ],
        ),
      )),
      floatingActionButton: SimulacaoVocal(),
    );
  }
}
