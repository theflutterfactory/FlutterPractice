import '../models/pokemon.dart';
import 'connected_pokemon.dart';

mixin PokemonModel on ConnectedPokemon {
  bool _showFavorites = false;

  List<Pokemon> get allpokemon {
    return List.from(pokemonList);
  }

  List<Pokemon> get displayedPokemon {
    if (_showFavorites) {
      return List.from(pokemonList.where((Pokemon pokemon) => pokemon.isFavorite).toList());
    }

    return List.from(pokemonList);
  }

  int get selectedPokemonIndex {
    return selPokemonIndex;
  }

  Pokemon get selectedPokemon {
    return selectedPokemonIndex != null ? pokemonList[selectedPokemonIndex] : null;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  void deletePokemon(int index) {
    pokemonList.removeAt(selectedPokemonIndex);
    selPokemonIndex = null;
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

    pokemonList[selectedPokemonIndex] = updatedPokemon;
    notifyListeners();
    selPokemonIndex = null;
  }

  void selectPokemon(int index) {
    selPokemonIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}
