import 'package:flutter/material.dart';

import 'pokemon_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pokemon"),
        ),
        body: PokemonManager('Gengar')
      )
    );
  }
}
