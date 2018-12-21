import 'package:scoped_model/scoped_model.dart';

import '../models/pokemon.dart';

class PokemonModel extends Model {
  List<Pokemon> _pokemonList = [];

  List<Pokemon> get pokemon {
    return List.from(_pokemonList);
  }

  void addPokemon(Pokemon pokemon) {
    _pokemonList.add(pokemon);
  }

  void updatePokemon(Pokemon pokemon, index) {
    _pokemonList[index] = pokemon;
  }

  void deletePokemon(int index) {
    _pokemonList.removeAt(index);
  }
}
