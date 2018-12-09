import 'package:flutter/material.dart';

import 'pokemon.dart';
import 'pokemon_control.dart';

class PokemonManager extends StatefulWidget {
  final String startingPokemon;

  PokemonManager(this.startingPokemon);

  @override
  State<StatefulWidget> createState() {
    return _PokemonManagerState();
  }
}

class _PokemonManagerState extends State<PokemonManager> {
  List<String> _pokemon = [];

  @override
  void initState() {
    super.initState();
    _pokemon.add(widget.startingPokemon);
  }

  void _addPokemon(String pokemon) {
    setState(() {
      _pokemon.add(pokemon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(margin: EdgeInsets.all(16), child: PokemonControl(_addPokemon)),
      Expanded(child: Pokemon(_pokemon))
    ]);
  }
}
