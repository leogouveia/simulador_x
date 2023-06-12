import 'package:flutter/material.dart';
import 'package:simulador_x/screens/simulacao_form_screen.dart';
import 'package:simulador_x/theme/app_colors.dart';
import 'package:simulador_x/utils/time_greeting.dart';
import 'package:simulador_x/widgets/recepcao_form.dart';

class SimulacaoRecepcao extends StatelessWidget {
  const SimulacaoRecepcao({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(6.0),
        color: AppColors.cinzaLighter1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(TimeGreeting.greeting(),
                      style: Theme.of(context).textTheme.displaySmall),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "Esta ferramenta foi projetada para tornar o processo de simulação de empréstimo mais rápido e eficiente.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child:
                      const Text("Poderia nos informar o seu nome, por favor?"),
                ),
                RecepcaoForm(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const SimulacaoFormScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = const Offset(1.0, 0.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
