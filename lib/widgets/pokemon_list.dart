import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './pokemon_card.dart';
import '../models/pokemon.dart';
import '../scoped-models/main.dart';

class PokemonList extends StatelessWidget {
  Widget _buildPokemonList(List<Pokemon> pokemonList) {
    Widget pokemonCard;

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
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return _buildPokemonList(model.displayedPokemon);
    });
  }
}
