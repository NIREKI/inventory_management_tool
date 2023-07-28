import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Test123'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: Row(children: [
          SafeArea(
            child: NavigationRail(
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.help),
                    label: Text("Hallo das ist ein Test!"),
                  ),
                  NavigationRailDestination(
                      icon: Icon(Icons.warning),
                      label: Text("Das ist ein zweiter test."))
                ],
                selectedIndex: 0,
                extended: true,
                onDestinationSelected: (value) {
                  if (value == 1) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyFirstPage()));
                  }
                }),
          )
        ]));
  }
}

class MyFirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(children: [
        NavigationRail(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.help),
                label: Text("Hallo das ist ein Test!"),
              ),
              NavigationRailDestination(
                  icon: Icon(Icons.warning),
                  label: Text("Das ist ein zweiter test."))
            ],
            selectedIndex: 0,
            extended: true,
            onDestinationSelected: (value) {
              if (value == 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyFirstPage()));
              }
            }),
        const Banner(message: "Hallo!", location: BannerLocation.topStart)
      ])),
    );
  }
}
