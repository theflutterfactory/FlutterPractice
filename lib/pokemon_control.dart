import 'package:flutter/material.dart';

class PokemonControl extends StatelessWidget {
  final Function addPokemon;

  PokemonControl(this.addPokemon);

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();

    return RaisedButton(
      child: Text(
        'Add Pokemon',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      color: Theme.of(context).accentColor,
      onPressed: () {
        addPokemon(
          {'title': 'Gengar' + now.second.toString(), 'image': 'assets/gengar.png'},
        );
      },
    );
  }
}
