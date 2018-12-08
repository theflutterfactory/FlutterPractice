import 'package:flutter/material.dart';

import 'pokemon.dart';

class PokemonManager extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _PokemonManagerState();
  }
}

class _PokemonManagerState extends State<PokemonManager>{
  List<String> pokemon = ['Gengar'];

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