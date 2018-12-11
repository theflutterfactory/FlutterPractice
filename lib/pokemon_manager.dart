import 'package:flutter/material.dart';

import 'pokemonList.dart';
import 'pokemon_control.dart';

class PokemonManager extends StatefulWidget {
  PokemonManager();

  @override
  State<StatefulWidget> createState() {
    return _PokemonManagerState();
  }
}

class _PokemonManagerState extends State<PokemonManager> {
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
    return Column(children: [
      Container(margin: EdgeInsets.all(16), child: PokemonControl(_addPokemon)),
      Expanded(
        child: PokemonList(_pokemonList, _deletePokemon),
      )
    ]);
  }
}
