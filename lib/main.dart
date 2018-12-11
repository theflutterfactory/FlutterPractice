import 'package:flutter/material.dart';

import './pages/auth.dart';
import './pages/pokemon_admin.dart';
import './pages/pokemon.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red, accentColor: Colors.purple),
      home: AuthPage(),
      routes: {
        '/pokemon': (context) => Pokemon(),
        '/admin': (context) => PokemonAdminPage(),
      },
    );
  }
}
