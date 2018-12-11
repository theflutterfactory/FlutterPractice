import 'package:flutter/material.dart';

import '../pokemon_manager.dart';

class Pokemon extends StatelessWidget {
  final List<Map<String, String>> pokemonList;
  final Function addPokemon;
  final Function deletePokemon;

  Pokemon(this.pokemonList, this.addPokemon, this.deletePokemon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text("Julian Currie"),
            ),
            ListTile(
              title: Text('Manage Pokemon'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/admin');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Pokemon"),
      ),
      body: PokemonManager(pokemonList, addPokemon, deletePokemon),
    );
  }
}
