import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simulador_x/models/simulacao_dados.dart';

class ResultadoSimulacaoState extends SimulacaoDados {
  final bool isLoading;
  final bool error;
  ResultadoSimulacaoState({
    this.isLoading = false,
    this.error = false,
    required super.codigoProduto,
    required super.descricaoProduto,
    required super.taxaJuros,
    required super.resultadoSimulacao,
  });

  static ResultadoSimulacaoState fromSimulacaoDados(SimulacaoDados dados) {
    return ResultadoSimulacaoState(
      codigoProduto: dados.codigoProduto,
      descricaoProduto: dados.descricaoProduto,
      taxaJuros: dados.taxaJuros,
      resultadoSimulacao: dados.resultadoSimulacao,
    );
  }

  ResultadoSimulacaoState copyWith({
    isLoading,
    error,
    codigoProduto,
    descricaoProduto,
    taxaJuros,
    resultadoSimulacao,
  }) {
    return ResultadoSimulacaoState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      codigoProduto: codigoProduto ?? this.codigoProduto,
      descricaoProduto: descricaoProduto ?? this.descricaoProduto,
      taxaJuros: taxaJuros ?? this.taxaJuros,
      resultadoSimulacao: resultadoSimulacao ?? this.resultadoSimulacao,
    );
  }
}

class ResultadoSimulacaoStateNotifier
    extends StateNotifier<ResultadoSimulacaoState?> {
  ResultadoSimulacaoStateNotifier() : super(null);

  void setLoading(bool isLoading) {
    state = state?.copyWith(isLoading: isLoading);
  }

  void setError(bool error) {
    state = state?.copyWith(error: error);
  }

  void setResultado(SimulacaoDados resultado) {
    state = ResultadoSimulacaoState.fromSimulacaoDados(resultado);
  }
}

final resultadoSimulacaoProvider = StateNotifierProvider<
    ResultadoSimulacaoStateNotifier, ResultadoSimulacaoState?>((ref) {
  return ResultadoSimulacaoStateNotifier();
});
