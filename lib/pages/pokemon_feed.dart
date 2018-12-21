import 'package:flutter/material.dart';

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
      ),
      body: PokemonList(),
    );
  }
}
