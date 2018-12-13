import 'package:flutter/material.dart';

import './pages/auth.dart';
import './pages/pokemon_admin.dart';
import './pages/pokemon.dart';
import './pages//pokemon_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> _pokemonList = [];

  void _addPokemon(Map<String, dynamic> pokemon) {
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
        '/pokemon': (context) => Pokemon(_pokemonList),
        '/admin': (context) => PokemonAdminPage(_addPokemon, _deletePokemon),
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
                  _pokemonList[index]['name'],
                  _pokemonList[index]['image'],
                ),
          );
        }

        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) => Pokemon(_pokemonList),
        );
      },
    );
  }
}
