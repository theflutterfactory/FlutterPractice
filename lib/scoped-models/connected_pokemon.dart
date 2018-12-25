import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/pokemon.dart';
import '../models/user.dart';

mixin ConnectedPokemonModel on Model {
  List<Pokemon> _pokemonList = [];
  User _authenticatedUser;
  int _selPokemonIndex;
  bool _isLoading = false;

  void addPokemon(Pokemon pokemon) {
    _isLoading = true;
    final CollectionReference pokemonRef = Firestore.instance.collection('pokemon');

    Map<String, dynamic> pokemonData = {
      "name": pokemon.name,
      "description": pokemon.description,
      "type": pokemon.type,
      "health": pokemon.startingHealth,
      "userEmail": _authenticatedUser.email,
      "userId": _authenticatedUser.id,
      "image": "https://i.pinimg.com/originals/b0/08/64/b00864b192f158302f647196c8998574.png"
    };

    pokemonRef.add(pokemonData).then((value) {
      _isLoading = false;
      pokemon.id = value.documentID;
      _pokemonList.add(pokemon);
      notifyListeners();
    });
  }

  void fetchPokemon() {
    _isLoading = true;
    _pokemonList.clear();

    final CollectionReference pokemonRef = Firestore.instance.collection('pokemon');
    pokemonRef.getDocuments().then((snapshot) {
      snapshot.documents.map((DocumentSnapshot document) {
        Pokemon pokemon = new Pokemon();
        pokemon.id = document.documentID;
        pokemon.name = document['name'];
        pokemon.description = document['description'];
        pokemon.type = document['type'];
        pokemon.image = document['image'];
        pokemon.userEmail = document['userEmail'];
        pokemon.startingHealth = document['health'];
        _pokemonList.add(pokemon);
      }).toList();

      _isLoading = false;

      notifyListeners();
    });
  }

  void updatePokemon(Pokemon pokemon) {
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
    updatedPokemon.userEmail = selectedPokemon.userEmail;
    updatedPokemon.userId = selectedPokemon.userId;
    updatedPokemon.isFavorite = newFavoriteStatus;

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

mixin UtilityModel on ConnectedPokemonModel {
  bool get isLoading {
    return _isLoading;
  }
}
