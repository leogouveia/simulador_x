import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:simulador_x/models/simulacao_dados.dart';
import 'package:simulador_x/models/warning_model.dart';

class FetchSimulacao {
  static Future<Either<SimulacaoDados, Warning>> getSimulacao(
      double valorDesejado, int prazo) async {
    Warning? warningResult;
    SimulacaoDados? simulacaoDadosResult;

    var url = Uri.parse(
        'https://apphackaixades.azurewebsites.net/api/Simulacao'); // Replace with your API endpoint

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: utf8.encode(json.encode({
        'valorDesejado': valorDesejado.toString(),
        'prazo': prazo.toString(),
      })),
    );

    if (response.statusCode == 200) {
      simulacaoDadosResult =
          SimulacaoDados.fromJson(json.decode(response.body));
      return Left(simulacaoDadosResult);
    } else if (response.statusCode == 400) {
      warningResult = Warning.fromJson(json.decode(response.body));
      return Right(warningResult);
    } else {
      throw const HttpException('Erro ao buscar simulação');
    }
  }
}
