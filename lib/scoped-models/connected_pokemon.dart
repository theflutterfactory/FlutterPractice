import 'dart:io';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/pokemon.dart';

mixin ConnectedPokemonModel on Model {
  List<Pokemon> _pokemonList = [];
  FirebaseUser _firebaseUser;
  String _selectedPokemonId;
  bool _isLoading = false;

  Future<dynamic> fetchPokemon({onlyForUser = false, showLoadingIndicator = true}) {
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
        pokemon.imageUrl = document['image'];
        pokemon.userEmail = document['userEmail'];
        pokemon.userId = document['userId'];
        pokemon.startingHealth = document['health'];
        pokemon.isFavorite = document['favoriteUsers'] == null
            ? false
            : (document['favoriteUsers'] as List<dynamic>).contains(_firebaseUser.uid);

        fetchedPokemonList.add(pokemon);
      }).toList();

      _pokemonList = onlyForUser
          ? fetchedPokemonList
              .where((Pokemon filteredPokemon) => filteredPokemon.userId == _firebaseUser.uid)
              .toList()
          : fetchedPokemonList;

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
      return List.from(_pokemonList.where((Pokemon pokemon) => pokemon.isFavorite));
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

  Future<bool> uploadPokemonAndImage(File imageFile, Pokemon pokemon, {String imagePath}) async {
    _isLoading = true;
    notifyListeners();

    print("uploadImage");
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(_firebaseUser.uid).child(pokemon.name);

    await firebaseStorageRef.putFile(imageFile).onComplete.catchError(
      (onError) {
        print(onError);
        _isLoading = false;
        notifyListeners();
        return false;
      },
    );

    String url = await firebaseStorageRef.getDownloadURL();
    print("url: " + url);

    return addPokemon(pokemon, url);
  }

  Future<bool> addPokemon(Pokemon pokemon, String imageUrl) async {
    final CollectionReference pokemonRef = Firestore.instance.collection('pokemon');

    Map<String, dynamic> pokemonData = {
      "name": pokemon.name,
      "description": pokemon.description,
      "type": pokemon.type,
      "health": pokemon.startingHealth,
      "userEmail": _firebaseUser.email,
      "userId": _firebaseUser.uid,
      "image": imageUrl
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
      "favoriteUsers": updatePokemon.favoriteUsers,
      "image": updatePokemon.imageUrl
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

  void toggleFavorite() async {
    final bool isFavorite = selectedPokemon.isFavorite;
    final bool newFavoriteStatus = !isFavorite;

    if (newFavoriteStatus) {
      await Firestore.instance.collection('pokemon').document(selectedPokemon.id).updateData({
        'favoriteUsers': FieldValue.arrayUnion([_firebaseUser.uid]),
      }).catchError((error) {
        _isLoading = false;
        notifyListeners();
        print(error);
        return false;
      });
    } else {
      await Firestore.instance.collection('pokemon').document(selectedPokemon.id).updateData({
        'favoriteUsers': FieldValue.arrayRemove([_firebaseUser.uid]),
      }).catchError((error) {
        _isLoading = false;
        notifyListeners();
        print(error);
        return false;
      });
    }

    final Pokemon updatedPokemon = Pokemon();
    updatedPokemon.id = selectedPokemon.id;
    updatedPokemon.name = selectedPokemon.name;
    updatedPokemon.description = selectedPokemon.description;
    updatedPokemon.startingHealth = selectedPokemon.startingHealth;
    updatedPokemon.imageUrl = selectedPokemon.imageUrl;
    updatedPokemon.type = selectedPokemon.type;
    updatedPokemon.userEmail = selectedPokemon.userEmail;
    updatedPokemon.userId = selectedPokemon.userId;
    updatedPokemon.favoriteUsers = selectedPokemon.favoriteUsers;
    updatedPokemon.isFavorite = newFavoriteStatus;

    _pokemonList[selectedPokemonIndex] = updatedPokemon;
    _isLoading = false;

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
  Future<FirebaseUser> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final FirebaseUser user = await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((onError) => print(onError));

    _isLoading = false;
    notifyListeners();
    return user;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<FirebaseUser> signup(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final FirebaseUser user = await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((onError) => print(onError));

    _isLoading = false;
    notifyListeners();
    return user;
  }

  Future<bool> signout() async {
    await FirebaseAuth.instance.signOut().catchError((onError) {
      print(onError);
      return false;
    });
    return true;
  }

  FirebaseUser get currentUser {
    return _firebaseUser;
  }

  set user(FirebaseUser user) {
    _firebaseUser = user;
  }
}

mixin UtilityModel on ConnectedPokemonModel {
  bool get isLoading {
    return _isLoading;
  }
}
