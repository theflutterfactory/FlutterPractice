import 'package:flutter/material.dart';

import './pokemon_create.dart';
import '../data/pokemon.dart';

class PokemonOwnedPage extends StatelessWidget {
  final List<Pokemon> pokemonList;

  PokemonOwnedPage(this.pokemonList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: Image.asset(
            pokemonList[index].image,
            height: 80,
          ),
          title: Text(pokemonList[index].name),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return PokemonCreatePage(pokemon: pokemonList[index]);
                }),
              );
            },
          ),
        );
      },
      itemCount: pokemonList.length,
    );
  }
}
