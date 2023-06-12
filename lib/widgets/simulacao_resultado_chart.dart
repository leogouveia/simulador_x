import 'package:flutter/material.dart';
import 'package:simulador_x/models/dados_chart.model.dart';
import 'package:simulador_x/theme/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SimulacaoResultadoChart extends StatelessWidget {
  final List<DadosChart> data;
  final String title;
  const SimulacaoResultadoChart(
      {super.key, required this.data, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(text: title),
      legend: Legend(isVisible: true),
      margin: const EdgeInsets.all(8.0),
      palette: const [
        AppColors.azulLighter1,
        AppColors.laranjaLighter1,
        AppColors.turquesa,
        AppColors.uva,
        AppColors.limao,
        AppColors.goiaba,
        AppColors.tangerina,
      ],
      series: [
        PieSeries(
          explode: true,
          explodeIndex: 0,
          dataSource: data,
          xValueMapper: (data, _) => data.xData,
          yValueMapper: (data, _) => data.yData,
          dataLabelMapper: (data, _) => data.text,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}
