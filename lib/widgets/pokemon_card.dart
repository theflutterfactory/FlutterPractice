import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/pokemon.dart';
import '../scoped-models/main.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
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
              pokemon.name,
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            Image.asset(pokemon.image, height: 150),
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.description),
                  color: Colors.white,
                  onPressed: () =>
                      Navigator.pushNamed<bool>(context, '/pokemon/' + pokemonIndex.toString()),
                ),
                ScopedModelDescendant<MainModel>(
                  builder: (BuildContext context, Widget child, MainModel model) {
                    return IconButton(
                      icon: Icon(model.pokemonList[pokemonIndex].isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border),
                      color: Colors.white,
                      onPressed: () {
                        model.selectPokemon(pokemonIndex);
                        model.toggleFavorite();
                      },
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
