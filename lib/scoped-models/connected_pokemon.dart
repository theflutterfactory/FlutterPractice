import 'package:scoped_model/scoped_model.dart';

import '../models/pokemon.dart';
import '../models/user.dart';

mixin ConnectedPokemonModel on Model {
  List<Pokemon> _pokemonList = [];
  User _authenticatedUser;
  int _selPokemonIndex;

  void addPokemon(Pokemon pokemon) {
    pokemon.user = _authenticatedUser;

    _pokemonList.add(pokemon);
    notifyListeners();
  }

  void updatePokemon(Pokemon pokemon) {
    pokemon.user = _authenticatedUser;

    _pokemonList[_selPokemonIndex] = pokemon;
    notifyListeners();
  }
}

mixin PokemonModel on ConnectedPokemonModel {
  bool _showFavorites = false;

  List<Pokemon> get allpokemon {
    return List.from(_pokemonList);
  }

  List<Pokemon> get displayedPokemon {
    if (_showFavorites) {
      return List.from(_pokemonList.where((Pokemon pokemon) => pokemon.isFavorite).toList());
    }

    return List.from(_pokemonList);
  }

  int get selectedPokemonIndex {
    return _selPokemonIndex;
  }

  Pokemon get selectedPokemon {
    return selectedPokemonIndex != null ? _pokemonList[selectedPokemonIndex] : null;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  void deletePokemon(int index) {
    _pokemonList.removeAt(selectedPokemonIndex);
    notifyListeners();
  }

  void toggleFavorite() {
    final bool isFavorite = selectedPokemon.isFavorite;
    final bool newFavoriteStatus = !isFavorite;
    final Pokemon updatedPokemon = Pokemon();
    updatedPokemon.name = selectedPokemon.name;
    updatedPokemon.description = selectedPokemon.description;
    updatedPokemon.startingHealth = selectedPokemon.startingHealth;
    updatedPokemon.image = selectedPokemon.image;
    updatedPokemon.type = selectedPokemon.type;
    updatedPokemon.isFavorite = newFavoriteStatus;
    updatedPokemon.user = selectedPokemon.user;

    _pokemonList[selectedPokemonIndex] = updatedPokemon;
    notifyListeners();
  }

  void selectPokemon(int index) {
    _selPokemonIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedPokemonModel {
  void login(String email, String password) {
    _authenticatedUser = User();
    _authenticatedUser.id = "testId";
    _authenticatedUser.email = email;
    _authenticatedUser.password = password;
  }
}
