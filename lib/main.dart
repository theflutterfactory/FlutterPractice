import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/auth.dart';
import './pages/pokemon_admin.dart';
import './pages/pokemon_feed.dart';
import './pages/pokemon_detail.dart';
import './scoped-models/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red, accentColor: Colors.purple),
        home: AuthPage(),
        routes: {
          '/pokemon_feed': (context) => PokemonFeed(),
          '/admin': (context) => PokemonAdminPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');

          if (pathElements[0] != '') {
            return null;
          }

          if (pathElements[1] == 'pokemon') {
            final int index = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(
              builder: (context) => PokemonDetail(index),
            );
          }

          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (context) => PokemonFeed(),
          );
        },
      ),
    );
  }
}
