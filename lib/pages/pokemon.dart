import 'package:flutter/material.dart';

import '../widgets/pokemon_list.dart';

class Pokemon extends StatelessWidget {
  final List<Map<String, dynamic>> pokemonList;

  Pokemon(this.pokemonList);

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
              leading: Icon(Icons.edit),
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
      body: PokemonList(pokemonList),
    );
  }
}
