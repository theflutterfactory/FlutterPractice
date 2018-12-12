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
    return Container(
      margin: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Name'),
            onChanged: (String value) {
              setState(() {
                name = value;
              });
            },
          ),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(labelText: 'Description'),
            onChanged: (String value) {
              setState(() {
                description = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Type'),
            onChanged: (String value) {
              setState(() {
                type = value;
              });
            },
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Starting Health'),
            onChanged: (String value) {
              setState(() {
                startingHealth = double.parse(value);
              });
            },
          ),
        ],
      ),
    );
  }
}
