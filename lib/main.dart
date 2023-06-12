import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl_standalone.dart';
import 'package:simulador_x/screens/home_screen.dart';
import 'package:simulador_x/screens/simulacao_form_screen.dart';
import 'package:simulador_x/screens/simulacao_resultado_screen.dart';
import 'package:simulador_x/theme/app_colors.dart';
import 'package:simulador_x/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.azulLighter3,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final ThemeData? theme;

  const MyApp({super.key, this.theme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulador CAIXA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(title: 'Simulador CAIXA'),
        '/form': (context) => const SimulacaoFormScreen(),
        '/loading': (context) => const SimulacaoFormScreen(),
        '/resultado_simulacao': (context) => const SimulacaoResultScreen(),
      },
    );
  }
}
