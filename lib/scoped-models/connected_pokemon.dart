import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/pokemon.dart';
import '../models/user.dart';

mixin ConnectedPokemonModel on Model {
  List<Pokemon> _pokemonList = [];
  User _authenticatedUser;
  String _selectedPokemonId;
  bool _isLoading = false;

  Future<dynamic> fetchPokemon(bool showLoadingIndicator) {
    if (showLoadingIndicator) {
      _isLoading = true;
      notifyListeners();
    }

    final CollectionReference pokemonRef = Firestore.instance.collection('pokemon');
    return pokemonRef.getDocuments().then<Null>((snapshot) {
      final List<Pokemon> fetchedPokemonList = [];

      snapshot.documents.map((DocumentSnapshot document) {
        Pokemon pokemon = new Pokemon();
        pokemon.id = document.documentID;
        pokemon.name = document['name'];
        pokemon.description = document['description'];
        pokemon.type = document['type'];
        pokemon.image = document['image'];
        pokemon.userEmail = document['userEmail'];
        pokemon.userId = document['userId'];
        pokemon.startingHealth = document['health'];
        fetchedPokemonList.add(pokemon);
      }).toList();

      _pokemonList = fetchedPokemonList;
      _isLoading = false;
      notifyListeners();
      _selectedPokemonId = null;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      print(error);
      return;
    });
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

  String get selectedPokemonId {
    return _selectedPokemonId;
  }

  int get selectedPokemonIndex {
    return _pokemonList.indexWhere((Pokemon pokemon) {
      return pokemon.id == selectedPokemonId;
    });
  }

  Pokemon get selectedPokemon {
    if (selectedPokemonId == null) {
      return null;
    }

    return _pokemonList.firstWhere((Pokemon pokemon) {
      return pokemon.id == selectedPokemonId;
    });
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Future<bool> addPokemon(Pokemon pokemon) {
    _isLoading = true;
    notifyListeners();

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

    return pokemonRef.add(pokemonData).then((value) {
      _isLoading = false;
      pokemon.id = value.documentID;
      _pokemonList.add(pokemon);
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      print(error);
      return false;
    });
  }

  Future<bool> updatePokemon(Pokemon updatePokemon) {
    print("Attempting to update id: " + updatePokemon.id.toString());

    Map<String, dynamic> updatedData = {
      "name": updatePokemon.name,
      "description": updatePokemon.description,
      "type": updatePokemon.type,
      "health": updatePokemon.startingHealth,
      "userEmail": updatePokemon.userEmail,
      "userId": updatePokemon.userId,
      "image": "https://i.pinimg.com/originals/b0/08/64/b00864b192f158302f647196c8998574.png"
    };

    return Firestore.instance
        .collection('pokemon')
        .document(updatePokemon.id)
        .updateData(updatedData)
        .then((_) {
      _isLoading = false;
      _pokemonList[selectedPokemonIndex] = updatePokemon;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      print(error);
      return false;
    });
  }

  Future<bool> deletePokemon() {
    _isLoading = true;
    final deletedPokemonId = selectedPokemon.id;
    _pokemonList.removeAt(selectedPokemonIndex);
    _selectedPokemonId = null;
    notifyListeners();

    return Firestore.instance.collection('pokemon').document(deletedPokemonId).delete().then((_) {
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      print(error);
      return false;
    });
  }

  void toggleFavorite() {
    final bool isFavorite = selectedPokemon.isFavorite;
    final bool newFavoriteStatus = !isFavorite;
    final Pokemon updatedPokemon = Pokemon();
    updatedPokemon.id = selectedPokemon.id;
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

  void selectPokemon(String pokemonId) {
    _selectedPokemonId = pokemonId;
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

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<FirebaseUser> signup(String email, String password) async {
    final FirebaseUser user =
        await auth.createUserWithEmailAndPassword(email: email, password: password);

    return user;
  }

  User get currentUser {
    return _authenticatedUser;
  }
}

mixin UtilityModel on ConnectedPokemonModel {
  bool get isLoading {
    return _isLoading;
  }
}
