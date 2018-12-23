import 'package:scoped_model/scoped_model.dart';

import '../models/pokemon.dart';
import '../models/user.dart';

mixin ConnectedPokemon on Model {
  List<Pokemon> pokemonList = [];
  User authenticatedUser;
  int selPokemonIndex;

  void addPokemon(Pokemon pokemon) {
    pokemon.user = authenticatedUser;

    pokemonList.add(pokemon);
    selPokemonIndex = null;
    notifyListeners();
  }

  void updatePokemon(Pokemon pokemon) {
    pokemon.user = authenticatedUser;

    pokemonList[selPokemonIndex] = pokemon;
    selPokemonIndex = null;
    notifyListeners();
  }
}
