import 'package:flutter/material.dart';

class Pokemon extends StatelessWidget {
  final List<String> pokemon;

  Pokemon(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Column(children: pokemon.map((element) =>Card(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Image.asset('assets/gengar.png'),
              Text(element)
            ],
          ),
        )
    )).toList()
    );
  }
}