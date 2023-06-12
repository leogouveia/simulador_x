import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simulador_x/theme/app_colors.dart';
import 'package:simulador_x/theme/app_gradients.dart';

class AppBarX extends StatelessWidget implements PreferredSize {
  final String title;
  final bool isOcean;
  const AppBarX({Key? key, required this.title, this.isOcean = false})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  Widget build(BuildContext context) {
    final List<Widget> barContent = [
      Container(
        margin: const EdgeInsets.all(8),
        child: SvgPicture.asset(
          'assets/images/elemento_sintese.svg',
          height: 24.0,
          width: 24.0,
        ),
      ),
      Text(title, style: const TextStyle(color: Colors.white)),
    ];

    final overlay = SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.primary,
      statusBarIconBrightness: Brightness.light,
    );

    if (isOcean) {
      return AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.cinzaLighter2,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppGradients.oceanGradient,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: barContent,
        ),
      );
    }

    return AppBar(
      key: key ?? const Key('app_bar'),
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
      centerTitle: true,
      systemOverlayStyle: overlay,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: barContent,
      ),
    );
  }

  @override
  Widget get child => Container();
}
