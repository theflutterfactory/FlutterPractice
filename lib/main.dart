import 'package:flutter/material.dart';

import 'pages/pokemon.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red, accentColor: Colors.purple),
      home: Pokemon(),
    );
  }
}
