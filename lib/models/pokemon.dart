import './user.dart';

class Pokemon {
  String id;
  String name;
  String description;
  String type;
  double startingHealth;
  String image = 'assets/pikachu.png';
  bool isFavorite = false;
  User user;

  Pokemon();
}
