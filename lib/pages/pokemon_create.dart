import 'package:flutter/material.dart';

class PokemonCreatePage extends StatefulWidget {
  final Function addProduct;

  PokemonCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _PokemonCreatePageState();
  }
}

class _PokemonCreatePageState extends State<PokemonCreatePage> {
  String _name = '';
  String _description = '';
  String _type = '';
  double _startingHealth;

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
                _name = value;
              });
            },
          ),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(labelText: 'Description'),
            onChanged: (String value) {
              setState(() {
                _description = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Type'),
            onChanged: (String value) {
              setState(() {
                _type = value;
              });
            },
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Starting Health'),
            onChanged: (String value) {
              setState(() {
                _startingHealth = double.parse(value);
              });
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {
                final Map<String, dynamic> pokmeon = {
                  'name': _name,
                  'description': _description,
                  'type': _type,
                  'startingHealth': _startingHealth,
                  'image': 'assets/pikachu.png'
                };

                Navigator.pushReplacementNamed(context, '/pokemon');
                widget.addProduct(pokmeon);
              },
            ),
          ),
        ],
      ),
    );
  }
}
