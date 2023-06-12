import 'package:flutter/material.dart';
import 'package:simulador_x/theme/app_colors.dart';

class AppTheme {
  static const textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'Futura BT',
      color: AppColors.azul,
      fontWeight: FontWeight.w800,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Futura BT',
      color: AppColors.azul,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Futura BT',
      color: AppColors.azul,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Futura BT',
      fontWeight: FontWeight.w700,
      color: AppColors.azul,
    ),
    displayLarge: TextStyle(
      fontFamily: 'FuturaBT',
      fontWeight: FontWeight.w700,
      color: AppColors.azul,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Futura BT',
      fontWeight: FontWeight.w700,
      color: AppColors.azul,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Futura BT',
      fontWeight: FontWeight.w700,
      color: AppColors.azul,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Futura BT',
      fontWeight: FontWeight.w700,
      color: AppColors.azul,
    ),
  );

  static final inputDecorationTheme = InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    fillColor: AppColors.cinzaLighter2,
    filled: true,
    hintStyle: const TextStyle(
      color: AppColors.azulLighter1,
    ),
    labelStyle: const TextStyle(
      color: AppColors.grafite,
    ),
    focusColor: AppColors.laranja,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(
        color: AppColors.azul,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(
        color: AppColors.danger,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(
        color: AppColors.danger,
      ),
    ),
    errorStyle: const TextStyle(color: AppColors.danger),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(
        color: AppColors.cinza,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(
        color: AppColors.cinzaDarker2,
      ),
    ),
  );

  static ThemeData getTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      fontFamily: 'FuturaBT',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.azul,
        secondary: AppColors.laranja,
        tertiary: AppColors.turquesa,
        onBackground: AppColors.cinzaLighter2,
        onPrimary: AppColors.cinzaLighter2,
        onSecondary: AppColors.cinzaLighter2,
      ),
      textTheme: textTheme,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.laranja,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: inputDecorationTheme,
    );
  }
}
