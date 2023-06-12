import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simulador_x/theme/app_gradients.dart';
import 'package:simulador_x/widgets/layouts/app_bar.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold(
      {super.key,
      required this.body,
      this.floatingActionButton,
      this.appBarTitle = 'Simulador Caixa',
      this.centerList = true});
  final Widget body;
  final Widget? floatingActionButton;
  final String appBarTitle;
  final bool centerList;

  @override
  Widget build(BuildContext context) {
    final child = centerList
        ? Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [body],
              ),
            ),
          )
        : body;
    return Scaffold(
      appBar: AppBarX(
        title: appBarTitle,
        isOcean: true,
      ),
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Stack(children: [
            Container(
              decoration: const BoxDecoration(
                gradient: AppGradients.oceanGradient,
              ),
            ),
            SvgPicture.asset(
              'assets/images/home_background3.svg',
              alignment: Alignment.bottomCenter,
              fit: BoxFit.fill,
            ),
            child,
          ]),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
