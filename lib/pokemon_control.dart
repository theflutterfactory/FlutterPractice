import 'package:flutter/material.dart';

class PokemonControl extends StatelessWidget {

  final Function addPokemon;

  PokemonControl(this.addPokemon);

  @override
  Widget build(BuildContext context) {
    return  RaisedButton(
      child: Text('Add Pokemon'),
      onPressed: (){
        addPokemon("Ghastly");
      },
    );
  }
}