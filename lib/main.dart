import 'package:flutter/material.dart';

import './pages/auth.dart';
import './pages/pokemon_admin.dart';
import './pages/pokemon_feed.dart';
import './pages/pokemon_detail.dart';
import './data/pokemon.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Pokemon> _pokemonList = [];

  void _addPokemon(Pokemon pokemon) {
    setState(() {
      _pokemonList.add(pokemon);
    });
  }

  void _updatePokemon(Pokemon pokemon, index) {
    setState(() {
      _pokemonList[index] = pokemon;
    });
  }

  void _deletePokemon(int index) {
    setState(() {
      _pokemonList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red, accentColor: Colors.purple),
      home: AuthPage(),
      routes: {
        '/pokemon_feed': (context) => PokemonFeed(_pokemonList),
        '/admin': (context) =>
            PokemonAdminPage(_addPokemon, _updatePokemon, _deletePokemon, _pokemonList),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');

        if (pathElements[0] != '') {
          return null;
        }

        if (pathElements[1] == 'pokemon') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (context) => PokemonDetail(
                  _pokemonList[index].name,
                  _pokemonList[index].image,
                  _pokemonList[index].description,
                ),
          );
        }

        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) => PokemonFeed(_pokemonList),
        );
      },
    );
  }
}
