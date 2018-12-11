import 'package:flutter/material.dart';

import './pokemon.dart';

class PokemonAdminPage extends StatelessWidget {
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
              title: Text('All Pokemon'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Pokemon()),
                );
              },
            )
          ],
        ),
      ),
      appBar: AppBar(title: Text('Manage Pokemon')),
      body: Center(
        child: Text('Manage Your Pokemon'),
      ),
    );
  }
}
