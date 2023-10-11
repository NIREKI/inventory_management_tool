import 'package:flutter/material.dart';
import 'package:flutter/src/services/mouse_cursor.dart';
import './db.dart';
import './createContract.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: MyHomePage(),
    );
  }
}

// ...

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
        break;
      case 1:
        page = ContractPage();
        break;
      default:
        throw UnimplementedError("Dieses Widget gibt es nicht!");
    }
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 800,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Übersicht'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.adf_scanner),
                    label: Text('Vertragsübersicht'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            //Expanded: Nimmt den größten Teil des Bildschirms ein.
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ContractPage extends StatefulWidget {
  const ContractPage({super.key});
  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  List<dynamic> _dbData = [];
  @override
  void initState() {
    // TODO: implement initState
    getDBasync();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getDBasync() async {
    List<dynamic> results = await getDatabase();
    if (mounted) {
      setState(() {
        _dbData = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
          child: DataTable(columns: const <DataColumn>[
        DataColumn(label: Text("VertragsID")),
        DataColumn(label: Text("Vergebene Nummer")),
        DataColumn(label: Text("Vertragspartner"))
      ], rows: <DataRow>[
        for (var result in _dbData)
          DataRow(cells: [
            DataCell(Text(result["contract"]!["id"].toString())),
            DataCell(Text(result["contract"]!["number"].toString())),
            DataCell(Text(result["contract"]!["provider"].toString()))
          ])
      ])),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Wrap(
          direction: Axis.horizontal,
          children: [
            GestureDetector(
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => createContract()))
              },
              child: BigMenuCard("Neuen Artikel anlegen",
                  "Über dieses Menü kann ein neuer Artikel angelegt werden."),
            ),
            GestureDetector(
              //onTap: () => getDatabase(),
              child: BigMenuCard("Neuen Leasingvertrag anlegen",
                  "In diesem Menü kann ein neuer Leasingvertrag angelegt werden. Leasingverträge fassen verschiedene Artikel zusammen."),
            ),
          ],
        ),
      ]),
    );
  }
}

// ...

class LikeButton extends StatelessWidget {
  const LikeButton({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Text("Gefällt mir"),
      ],
    );
  }
}

class BigMenuCard extends StatefulWidget {
  String title = "";
  String desc = "";
  BigMenuCard(String ptitle, String description) {
    this.title = ptitle;
    this.desc = description;
  }
  @override
  State<BigMenuCard> createState() => _BigMenuCardState();

  void getHelp() {}
}

class _BigMenuCardState extends State<BigMenuCard> {
  SystemMouseCursor cursor = SystemMouseCursors.basic;
  Color backgroundColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    final desc = widget.desc;
    final theme = Theme.of(context);
    //backgroundColor = theme.colorScheme.secondaryContainer;
    return MouseRegion(
      onHover: (event) => setState(() {
        cursor = SystemMouseCursors.click;
        backgroundColor = theme.colorScheme.inversePrimary;
      }),
      onExit: (event) => setState(() {
        backgroundColor = Colors.black;
      }),
      cursor: cursor,
      child: SizedBox(
        width: 400,
        height: 300,
        child: Card(
          surfaceTintColor: backgroundColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(title, style: theme.textTheme.headlineMedium),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(desc, style: theme.textTheme.labelMedium),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
