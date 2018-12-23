import 'package:scoped_model/scoped_model.dart';

import '../models/pokemon.dart';
import '../models/user.dart';

mixin ConnectedPokemon on Model {
  List<Pokemon> pokemonList = [];
  User authenticatedUser;
  int selectedPokemonIndex;

  void addPokemon(Pokemon pokemon) {
    pokemon.user = authenticatedUser;

    pokemonList.add(pokemon);
    selectedPokemonIndex = null;
    notifyListeners();
  }
}
