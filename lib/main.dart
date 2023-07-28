import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/mouse_cursor.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void deleteFavorite(WordPair fave) {
    favorites.remove(fave);
    notifyListeners();
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
        page = ItemsPage();
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
                    icon: Icon(Icons.favorite),
                    label: Text('Favoriten'),
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

class ItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: ListView(
          children: [
            ListTile(title: Text("hallo")),
            ListTile(title: Text("hallo")),
            ListTile(title: Text("hallo")),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        direction: Axis.horizontal,
        children: [
          BigMenuCard("Neuen Artikel anlegen",
              "Über dieses Menü kann ein neuer Artikel angelegt werden."),
          BigMenuCard("Neuen Leasingvertrag anlegen",
              "In diesem Menü kann ein neuer Leasingvertrag angelegt werden. Leasingverträge fassen verschiedene Artikel zusammen."),
        ],
      ),
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

class BigTextCard extends StatelessWidget {
  const BigTextCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      letterSpacing: 3,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Text(pair.asLowerCase,
            style: style, semanticsLabel: "${pair.first} ${pair.second}"),
      ),
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
      child: GestureDetector(
        child: SizedBox(
          width: 500,
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
      ),
    );
  }
}
