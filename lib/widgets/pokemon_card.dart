import 'package:flutter/material.dart';

import '../ui/button_dark.dart';

class PokemonCard extends StatelessWidget {
  final Map<String, dynamic> pokemon;
  final int pokemonIndex;

  PokemonCard(this.pokemon, this.pokemonIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              pokemon['name'],
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            Image.asset(pokemon['image'], height: 150),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                DarkButton(
                    'DETAILS',
                    () =>
                        Navigator.pushNamed<bool>(context, '/pokemon/' + pokemonIndex.toString())),
              ],
            )
          ],
        ),
      ),
    );
  }
}
