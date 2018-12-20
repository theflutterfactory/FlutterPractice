import 'package:flutter/material.dart';

import './pokemon_card.dart';
import '../models/pokemon.dart';

class PokemonList extends StatelessWidget {
  final List<Pokemon> pokemonList;

  PokemonList(this.pokemonList);

  Widget _buildPokemonList() {
    Widget pokemonCard = Center(
      child: Text("No Pokemon found, Go ahead and add one"),
    );

    if (pokemonList.length > 0) {
      pokemonCard = ListView.builder(
        itemBuilder: (BuildContext context, int index) => PokemonCard(pokemonList[index], index),
        itemCount: pokemonList.length,
      );
    }
    return pokemonCard;
  }

  @override
  Widget build(BuildContext context) {
    return _buildPokemonList();
  }
}
