import 'package:flutter/material.dart';

import 'pokemonList.dart';
import 'pokemon_control.dart';

class PokemonManager extends StatelessWidget {
  final List<Map<String, String>> pokemonList;
  final Function addPokemon;
  final Function deletePokemon;

  PokemonManager(this.pokemonList, this.addPokemon, this.deletePokemon);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(margin: EdgeInsets.all(16), child: PokemonControl(addPokemon)),
      Expanded(
        child: PokemonList(pokemonList, deletePokemon),
      )
    ]);
  }
}
