import 'package:scoped_model/scoped_model.dart';

import './pokemon.dart';
import './user.dart';
import './connected_pokemon.dart';

class MainModel extends Model with ConnectedPokemon, UserModel, PokemonModel {}
