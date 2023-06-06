import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl_standalone.dart';
import 'package:json_theme/json_theme.dart';
import 'package:simulador_x/screens/home_screen.dart';
import 'package:simulador_x/utils/x-colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();
  final themeStr = await rootBundle.loadString('assets/theme.json');
  final themeJson = json.decode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson);

  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  final ThemeData? theme;

  const MyApp({super.key, this.theme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulador CAIXA',
      theme: theme!.copyWith(
        useMaterial3: false,
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Futura BT',
            color: kxColors.azul.standard,
            fontWeight: FontWeight.w800,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Futura BT',
            color: kxColors.azul.standard,
            fontWeight: FontWeight.w700,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Futura BT',
            color: kxColors.azul.standard,
            fontWeight: FontWeight.w700,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Futura BT',
            fontWeight: FontWeight.w700,
            color: kxColors.azul.standard,
          ),
          displayLarge: TextStyle(
            fontFamily: 'FuturaBT',
            fontWeight: FontWeight.w700,
            color: kxColors.azul.standard,
          ),
          displayMedium: const TextStyle(
            fontFamily: 'Futura BT',
          ),
          displaySmall: const TextStyle(
            fontFamily: 'Futura BT',
          ),
          titleMedium: TextStyle(
            fontFamily: 'Futura BT',
            color: kxColors.grafite.standard,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: kxColors.cinza.lighter_1,
          filled: true,
          hoverColor: kxColors.laranja.standard,
          hintStyle: TextStyle(
            color: kxColors.grafite.lighter_1,
          ),
          labelStyle: TextStyle(
            color: kxColors.grafite.standard,
          ),
          focusColor: kxColors.laranja.standard,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
              color: kxColors.azul.standard,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
              color: kxColors.danger.standard,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
              color: kxColors.danger.standard,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
              color: kxColors.cinza.standard,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
              color: kxColors.cinza.darker_2,
            ),
          ),
        ),
      ),
      home: const HomeScreen(title: 'Simulador CAIXA'),
    );
  }
}
