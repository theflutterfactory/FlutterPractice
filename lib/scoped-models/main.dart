import 'package:scoped_model/scoped_model.dart';

import './pokemon.dart';
import './user.dart';

class MainModel extends Model with UserModel, PokemonModel {}
