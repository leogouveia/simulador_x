import 'package:flutter/material.dart';

class ColorShadesSimple {
  final Color standard;
  final Color darker_1;
  final Color darker_2;
  final Color lighter_1;
  final Color lighter_2;

  const ColorShadesSimple({
    required this.standard,
    required this.darker_1,
    required this.darker_2,
    required this.lighter_1,
    required this.lighter_2,
  });
}

class ColorShades extends ColorShadesSimple {
  final Color lighter_3;
  final Color lighter_4;
  final Color lighter_5;

  const ColorShades({
    required Color standard,
    required Color darker_1,
    required Color darker_2,
    required Color lighter_1,
    required Color lighter_2,
    required this.lighter_3,
    required this.lighter_4,
    required this.lighter_5,
  }) : super(
          standard: standard,
          darker_1: darker_1,
          darker_2: darker_2,
          lighter_1: lighter_1,
          lighter_2: lighter_2,
        );
}

class Colors {
  final ColorShades azul;
  final ColorShades laranja;
  final ColorShadesSimple turquesa;
  final ColorShadesSimple grafite;
  final ColorShadesSimple cinza;
  final ColorShadesSimple info;
  final ColorShades success;
  final ColorShades warning;
  final ColorShades danger;
  final ColorShadesSimple ceu;
  final ColorShadesSimple uva;
  final ColorShadesSimple limao;
  final ColorShadesSimple tangerina;
  final ColorShadesSimple goiaba;
  final Map<String, Color> background;

  const Colors({
    required this.azul,
    required this.laranja,
    required this.turquesa,
    required this.grafite,
    required this.cinza,
    required this.info,
    required this.success,
    required this.warning,
    required this.danger,
    required this.ceu,
    required this.uva,
    required this.limao,
    required this.tangerina,
    required this.goiaba,
    required this.background,
  });
}

const kxColors = Colors(
  azul: ColorShades(
    standard: Color(0xFF005CA9),
    darker_1: Color(0xFF004075),
    darker_2: Color(0xFF002442),
    lighter_1: Color(0xFF0077DB),
    lighter_2: Color(0xFF0F92FF),
    lighter_3: Color(0xFFC6E5FF),
    lighter_4: Color(0xFFE2F2FF),
    lighter_5: Color(0xFFF1F9FF),
  ),
  laranja: ColorShades(
    standard: Color(0xFFF59200),
    darker_1: Color(0xFFC27300),
    darker_2: Color(0xFF8F5500),
    lighter_1: Color(0xFFFFA829),
    lighter_2: Color(0xFFFFBD5C),
    lighter_3: Color(0xFFFFEDD2),
    lighter_4: Color(0xFFFFF4E5),
    lighter_5: Color(0xFFFFFAF2),
  ),
  turquesa: ColorShadesSimple(
    standard: Color(0xFF54BBAB),
    darker_1: Color(0xFF3E9D8E),
    darker_2: Color(0xFF30786D),
    lighter_1: Color(0xFF78C9BD),
    lighter_2: Color(0xFF9CD8CF),
  ),
  grafite: ColorShadesSimple(
    standard: Color(0xFF3A4859),
    darker_1: Color(0xFF262F3B),
    darker_2: Color(0xFF12161C),
    lighter_1: Color(0xFF4E6178),
    lighter_2: Color(0xFF637A97),
  ),
  cinza: ColorShadesSimple(
    standard: Color(0xFFD0E0E3),
    darker_1: Color(0xFFAFCACF),
    darker_2: Color(0xFF8FB5BC),
    lighter_1: Color(0xFFEFF4F5),
    lighter_2: Color(0xFFFFFFFF),
  ),
  info: ColorShadesSimple(
    standard: Color(0xFF143DA6),
    darker_1: Color(0xFF0E2B76),
    darker_2: Color(0xFF091B49),
    lighter_1: Color(0xFF194DD1),
    lighter_2: Color(0xFF3768E7),
  ),
  success: ColorShades(
    standard: Color(0xFF008254),
    darker_1: Color(0xFF004D31),
    darker_2: Color(0xFF001A10),
    lighter_1: Color(0xFF00B273),
    lighter_2: Color(0xFF00E594),
    lighter_3: Color(0xFFC2F9E6),
    lighter_4: Color(0xFFE0FBF2),
    lighter_5: Color(0xFFEBFDF7),
  ),
  warning: ColorShades(
    standard: Color(0xFFFFD000),
    darker_1: Color(0xFFCCA600),
    darker_2: Color(0xFF876E01),
    lighter_1: Color(0xFFFFD933),
    lighter_2: Color(0xFFFFE366),
    lighter_3: Color(0xFFFFF6CE),
    lighter_4: Color(0xFFFFFAE6),
    lighter_5: Color(0xFFFFFDF3),
  ),
  danger: ColorShades(
    standard: Color(0xFF900000),
    darker_1: Color(0xFF5C0000),
    darker_2: Color(0xFF290000),
    lighter_1: Color(0xFFC20000),
    lighter_2: Color(0xFFF50000),
    lighter_3: Color(0xFFFDD6D6),
    lighter_4: Color(0xFFFFEBEB),
    lighter_5: Color(0xFFFFF5F5),
  ),
  ceu: ColorShadesSimple(
    standard: Color(0xFF00B4E6),
    darker_1: Color(0xFF008CB2),
    darker_2: Color(0xFF006480),
    lighter_1: Color(0xFF1ACDFF),
    lighter_2: Color(0xFF4DD8FF),
  ),
  uva: ColorShadesSimple(
    standard: Color(0xFFB2709B),
    darker_1: Color(0xFF9C5483),
    darker_2: Color(0xFF7B4267),
    lighter_1: Color(0xFFC492B3),
    lighter_2: Color(0xFFD6B3CA),
  ),
  limao: ColorShadesSimple(
    standard: Color(0xFFB2CB0B),
    darker_1: Color(0xFF889B08),
    darker_2: Color(0xFF5D6A06),
    lighter_1: Color(0xFFD6F217),
    lighter_2: Color(0xFFDEF547),
  ),
  tangerina: ColorShadesSimple(
    standard: Color(0xFFFAAF00),
    darker_1: Color(0xFFC78B00),
    darker_2: Color(0xFF946800),
    lighter_1: Color(0xFFFFC02E),
    lighter_2: Color(0xFFFFD061),
  ),
  goiaba: ColorShadesSimple(
    standard: Color(0xFFEF755D),
    darker_1: Color(0xFFEA4D2E),
    darker_2: Color(0xFFD13415),
    lighter_1: Color(0xFFF49C8B),
    lighter_2: Color(0xFFF8C4B9),
  ),
  background: {
    'porcelana': Color(0xFFF9FBFB),
    'polar': Color(0xFFF6F9F9),
  },
);
