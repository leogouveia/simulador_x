class SimulacaoDados {
  final int codigoProduto;
  final String descricaoProduto;
  final double taxaJuros;
  final List<ResultadoSimulacao> resultadoSimulacao;

  SimulacaoDados({
    required this.codigoProduto,
    required this.descricaoProduto,
    required this.taxaJuros,
    required this.resultadoSimulacao,
  });

  factory SimulacaoDados.fromJson(Map<String, dynamic> json) {
    List<dynamic>? resultadoSimulacaoJson = json['resultadoSimulacao'] ?? [];
    List<ResultadoSimulacao> resultadoSimulacaoList =
        resultadoSimulacaoJson != null
            ? resultadoSimulacaoJson
                .map((resultJson) => ResultadoSimulacao.fromJson(resultJson))
                .toList()
            : [];

    return SimulacaoDados(
      codigoProduto: json['codigoProduto'] ?? 0,
      descricaoProduto: json['descricaoProduto'] ?? '',
      taxaJuros: json['taxaJuros']?.toDouble() ?? 0.0,
      resultadoSimulacao: resultadoSimulacaoList,
    );
  }
}

class ResultadoSimulacao {
  final String tipo;
  final List<Parcela> parcelas;

  ResultadoSimulacao({
    required this.tipo,
    required this.parcelas,
  });

  factory ResultadoSimulacao.fromJson(Map<String, dynamic> json) {
    List<dynamic>? parcelasJson = json["parcelas"] as List<dynamic>?;
    List<Parcela> parcelas = parcelasJson != null
        ? parcelasJson
            .map((resultJson) => Parcela.fromJson(resultJson))
            .toList()
        : [];

    return ResultadoSimulacao(tipo: json["tipo"] ?? "", parcelas: parcelas);
  }
}

class Parcela {
  final int numero;
  final double valorAmortizacao;
  final double valorJuros;
  final double valorPrestacao;

  Parcela({
    required this.numero,
    required this.valorAmortizacao,
    required this.valorJuros,
    required this.valorPrestacao,
  });

  factory Parcela.fromJson(Map<String, dynamic> json) {
    return Parcela(
      numero: json["numero"] ?? 0,
      valorAmortizacao: json["valorAmortizacao"]?.toDouble() ?? 0.0,
      valorJuros: json["valorJuros"]?.toDouble() ?? 0.0,
      valorPrestacao: json["valorPrestacao"]?.toDouble() ?? 0.0,
    );
  }
}
