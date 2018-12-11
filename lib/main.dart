import 'package:flutter/material.dart';

import './pages/auth.dart';
import './pages/pokemon_admin.dart';
import './pages/pokemon.dart';
import './pages//pokemonDetail.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, String>> _pokemonList = [];

  void _addPokemon(Map<String, String> pokemon) {
    setState(() {
      _pokemonList.add(pokemon);
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
        '/pokemon': (context) => Pokemon(_pokemonList, _addPokemon, _deletePokemon),
        '/admin': (context) => PokemonAdminPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');

        Set<String> set = Set.from(pathElements);
        set.forEach((element) => print(element));

        if (pathElements[0] != '') {
          return null;
        }

        if (pathElements[1] == 'pokemon') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (context) => PokemonDetail(
                  _pokemonList[index]['title'],
                  _pokemonList[index]['image'],
                ),
          );
        }

        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) => Pokemon(_pokemonList, _addPokemon, _deletePokemon),
        );
      },
    );
  }
}
