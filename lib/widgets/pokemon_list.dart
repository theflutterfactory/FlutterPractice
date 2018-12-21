import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './pokemon_card.dart';
import '../models/pokemon.dart';
import '../scoped-models/pokemon.dart';

class PokemonList extends StatelessWidget {
  Widget _buildPokemonList(List<Pokemon> pokemonList) {
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
    return ScopedModelDescendant<PokemonModel>(
        builder: (BuildContext context, Widget child, PokemonModel model) {
      return _buildPokemonList(model.pokemon);
    });
  }
}
