import 'package:flutter/material.dart';

import '../pokemon_manager.dart';

class Pokemon extends StatelessWidget {
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
              onTap: () {},
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Pokemon"),
      ),
      body: PokemonManager(),
    );
  }
}