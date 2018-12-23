import 'package:scoped_model/scoped_model.dart';

import '../models/pokemon.dart';

mixin PokemonModel on Model {
  List<Pokemon> _pokemonList = [];
  int _selectedPokemonIndex;
  bool _showFavorites = false;

  List<Pokemon> get pokemonList {
    return List.from(_pokemonList);
  }

  List<Pokemon> get displayedPokemon {
    if (_showFavorites) {
      return List.from(_pokemonList.where((Pokemon pokemon) => pokemon.isFavorite).toList());
    }

    return List.from(_pokemonList);
  }

  int get selectedPokemonIndex {
    return _selectedPokemonIndex;
  }

  Pokemon get selectedPokemon {
    return _selectedPokemonIndex != null ? _pokemonList[_selectedPokemonIndex] : null;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  void addPokemon(Pokemon pokemon) {
    _pokemonList.add(pokemon);
    _selectedPokemonIndex = null;
    notifyListeners();
  }

  void updatePokemon(Pokemon pokemon) {
    _pokemonList[_selectedPokemonIndex] = pokemon;
    _selectedPokemonIndex = null;
    notifyListeners();
  }

  void deletePokemon(int index) {
    _pokemonList.removeAt(_selectedPokemonIndex);
    _selectedPokemonIndex = null;
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

    _pokemonList[_selectedPokemonIndex] = updatedPokemon;
    notifyListeners();
    _selectedPokemonIndex = null;
  }

  void selectPokemon(int index) {
    _selectedPokemonIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}
