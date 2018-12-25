import 'package:scoped_model/scoped_model.dart';

import './connected_pokemon.dart';

class MainModel extends Model with ConnectedPokemonModel, UserModel, PokemonModel, UtilityModel {}
