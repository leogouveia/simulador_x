import 'package:flutter/material.dart';

class Warning extends StatelessWidget {
  const Warning({super.key, required this.warningText});
  final String warningText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Atenção'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(warningText),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
