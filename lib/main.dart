import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './pages/auth.dart';
import './models/pokemon.dart';
import './pages/pokemon_admin.dart';
import './pages/pokemon_feed.dart';
import './pages/pokemon_detail.dart';
import './scoped-models/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red, accentColor: Colors.purple),
        home: AuthPage(model),
        routes: {
          '/pokemon_feed': (context) => PokemonFeed(model),
          '/admin': (context) => PokemonAdminPage(model),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');

          if (pathElements[0] != '') {
            return null;
          }

          if (pathElements[1] == 'pokemon') {
            final String pokemonId = pathElements[2];
            final Pokemon pokemon = model.allpokemon.firstWhere((Pokemon pokemon) {
              return pokemon.id == pokemonId;
            });
            return MaterialPageRoute<bool>(
              builder: (context) => PokemonDetail(pokemon),
            );
          }

          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (context) => PokemonFeed(model),
          );
        },
      ),
    );
  }
}
