class Warning {
  final int codigo;
  final String mensagem;

  Warning({required this.codigo, required this.mensagem});

  factory Warning.fromJson(Map<String, dynamic> json) {
    return Warning(
        codigo: json["Codigo"] ?? 0, mensagem: json["Mensagem"] ?? "");
  }
}
