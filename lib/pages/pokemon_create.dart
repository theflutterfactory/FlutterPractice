import 'package:flutter/material.dart';

class PokemonCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PokemonCreatePageState();
  }
}

class _PokemonCreatePageState extends State<PokemonCreatePage> {
  String name = '';
  String description = '';
  String type = '';
  double startingHealth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (String value) {
            setState(() {
              name = value;
            });
          },
        ),
        TextField(
          maxLines: 4,
          onChanged: (String value) {
            setState(() {
              description = value;
            });
          },
        ),
        TextField(
          onChanged: (String value) {
            setState(() {
              type = value;
            });
          },
        ),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (String value) {
            setState(() {
              startingHealth = double.parse(value);
            });
          },
        ),
      ],
    );
  }
}
