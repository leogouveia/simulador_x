import 'package:flutter/material.dart';
import 'package:simulador_x/components/simulacao_vocal.dart';
import 'package:simulador_x/components/simulador_form.dart';
import 'package:simulador_x/layouts/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(title: 'Simulador Caixa'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SimuladorForm()],
        ),
      ),
      floatingActionButton: SimulacaoVocal(),
    );
  }
}
