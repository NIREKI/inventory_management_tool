import 'package:flutter/material.dart';

class createContract extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Row(children: [
        BackButton(onPressed: () => Navigator.pop(context)),
        Text(
          "Einen neuen Vertrag anlegen",
          style: theme.textTheme.displaySmall,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
