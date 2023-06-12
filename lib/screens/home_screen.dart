import 'package:flutter/material.dart';
import 'package:simulador_x/widgets/app_scaffold.dart';
import 'package:simulador_x/widgets/simulacao_recepcao.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: SimulacaoRecepcao(),
    );
  }
}
