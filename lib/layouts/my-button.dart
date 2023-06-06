import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;
  const MyButton({super.key, required this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            backgroundColor: MaterialStateColor.resolveWith(
              (states) => Theme.of(context).colorScheme.secondary,
            ),
            fixedSize: MaterialStateProperty.all<Size>(
              const Size.fromHeight(60),
            )),
        onPressed: () => onTap != null ? onTap!() : null,
        child: Text(buttonText),
      ),
    );
  }
}
