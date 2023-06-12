import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppState {
  AppState(this.valorDesejado, this.valorPrazo, this.isLoading, this.isError);
  final double valorDesejado;
  final int valorPrazo;
  final bool isLoading;
  final bool isError;

  AppState copyWith({
    double? valorDesejado,
    int? valorPrazo,
    bool? isLoading,
    bool? isError,
  }) {
    return AppState(
      valorDesejado ?? this.valorDesejado,
      valorPrazo ?? this.valorPrazo,
      isLoading ?? this.isLoading,
      isError ?? this.isError,
    );
  }
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState(0, 0, false, false));

  void setValorDesejado(double valorDesejado) {
    state = state.copyWith(valorDesejado: valorDesejado);
  }

  void setValorPrazo(int valorPrazo) {
    state = state.copyWith(valorPrazo: valorPrazo);
  }

  void setIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setIsError(bool isError) {
    state = state.copyWith(isError: isError);
  }

  void setSimulacao(double double, int prazo) {
    state = state.copyWith(
      valorDesejado: double,
      valorPrazo: prazo,
    );
  }
}

final appProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});
