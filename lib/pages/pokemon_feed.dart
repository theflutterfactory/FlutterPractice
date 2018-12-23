import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/pokemon.dart';
import '../widgets/pokemon_list.dart';

class PokemonFeed extends StatelessWidget {
  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text("Pokemon"),
        actions: <Widget>[
          ScopedModelDescendant<PokemonModel>(
              builder: (BuildContext context, Widget child, PokemonModel model) {
            return IconButton(
              icon: Icon(model.displayFavoritesOnly ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                model.toggleDisplayMode();
              },
            );
          })
        ],
      ),
      body: PokemonList(),
    );
  }
}
