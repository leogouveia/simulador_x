import 'package:flutter/material.dart';
import 'package:simulador_x/theme/app_colors.dart';

class AppGradients {
  static const oceanGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.azul, AppColors.turquesa], // replace with your colors
  );

  static const ceuGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.azul, AppColors.ceu, AppColors.ceu],
    stops: [0.0, 0.3, 0.7],
  );

  static const gradienteUva = LinearGradient(
    colors: [
      AppColors.azul,
      AppColors.uva,
      AppColors.uva,
    ],
    stops: [0.0, 0.3, 0.7],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const gradienteLimao = LinearGradient(
    colors: [
      AppColors.limao,
      AppColors.turquesa,
      AppColors.azul,
    ],
    stops: [0.0, 0.4, 0.7],
    begin: Alignment.center,
    end: Alignment.center,
    transform: GradientRotation(270 * 3.1415927 / 180),
  );

  static const gradienteTangerina = LinearGradient(
    colors: [
      AppColors.tangerina,
      AppColors.turquesa,
      AppColors.azul,
    ],
    stops: [0.0, 0.4, 0.7],
    begin: Alignment.center,
    end: Alignment.center,
    transform: GradientRotation(270 * 3.1415927 / 180),
  );

  static const gradienteGoiaba = LinearGradient(
    colors: [
      AppColors.azul,
      AppColors.goiaba,
      AppColors.goiaba,
    ],
    stops: [0.0, 0.3, 1.0],
    begin: Alignment.center,
    end: Alignment.center,
    transform: GradientRotation(90 * 3.1415927 / 180),
  );

  static const gradienteTurquesa = LinearGradient(
    colors: [
      AppColors.turquesa,
      AppColors.ceu,
    ],
    stops: [0.0, 1.0],
    begin: Alignment.center,
    end: Alignment.center,
    transform: GradientRotation(90 * 3.1415927 / 180),
  );

  static const gradientePrimavera = LinearGradient(
    colors: [
      AppColors.turquesa,
      AppColors.uva,
    ],
    stops: [0.0, 1.0],
    begin: Alignment.center,
    end: Alignment.center,
    transform: GradientRotation(90 * 3.1415927 / 180),
  );

  static const gradienteInverno = LinearGradient(
    colors: [
      AppColors.turquesa,
      AppColors.limao,
    ],
    stops: [0.0, 1.0],
    begin: Alignment.center,
    end: Alignment.center,
    transform: GradientRotation(90 * 3.1415927 / 180),
  );

  static const gradienteVerao = LinearGradient(
    colors: [
      AppColors.turquesa,
      AppColors.tangerina,
    ],
    stops: [0.0, 1.0],
    begin: Alignment.center,
    end: Alignment.center,
    transform: GradientRotation(90 * 3.1415927 / 180),
  );

  static const gradienteOutono = LinearGradient(
    colors: [
      AppColors.turquesa,
      AppColors.goiaba,
    ],
    stops: [0.0, 1.0],
    begin: Alignment.center,
    end: Alignment.center,
    transform: GradientRotation(90 * 3.1415927 / 180),
  );
}
