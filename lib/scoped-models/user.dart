import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';
import 'connected_pokemon.dart';

mixin UserModel on ConnectedPokemon {
  void login(String email, String password) {
    authenticatedUser = User();
    authenticatedUser.id = "testId";
    authenticatedUser.email = email;
    authenticatedUser.password = password;
  }
}
