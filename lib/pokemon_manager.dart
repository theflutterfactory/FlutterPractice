import 'package:flutter/material.dart';

import 'pokemon.dart';
import 'pokemon_control.dart';

class PokemonManager extends StatefulWidget {
  PokemonManager();

  @override
  State<StatefulWidget> createState() {
    return _PokemonManagerState();
  }
}

class _PokemonManagerState extends State<PokemonManager> {
  List<String> _pokemonList = [];

  void _addPokemon(String pokemon) {
    setState(() {
      _pokemonList.add(pokemon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(margin: EdgeInsets.all(16), child: PokemonControl(_addPokemon)),
      Expanded(child: Pokemon(_pokemonList))
    ]);
  }
}
