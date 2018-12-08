import 'package:flutter/material.dart';

import 'pokemon.dart';

class PokemonManager extends StatefulWidget{

  final String startingPokemon;

  PokemonManager(this.startingPokemon);

  @override
  State<StatefulWidget> createState() {
    return _PokemonManagerState();
  }
}

class _PokemonManagerState extends State<PokemonManager>{
  List<String> pokemon = [];

  @override
  void initState() {
    pokemon.add(widget.startingPokemon);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(10),
        child: RaisedButton(
          child: Text('Add Pokemon'),
          onPressed: (){
            setState(() {
              pokemon.add("Mew");
            });
          },
        )
    ),
      Pokemon(pokemon)
    ]);
  }
}