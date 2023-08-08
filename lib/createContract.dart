import 'package:flutter/material.dart';

class createContract extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          title: Text("Einen neuen Vertrag anlegen",
              style: TextStyle(color: Colors.white))),
      body: Column(children: [Row()]),
    );
  }
}
