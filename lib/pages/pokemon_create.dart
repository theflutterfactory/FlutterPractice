import 'package:flutter/material.dart';

import '../ui/button_dark.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitPokemon() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    final Map<String, dynamic> pokmeon = {
      'name': _name,
      'description': _description,
      'type': _type,
      'startingHealth': _startingHealth,
      'image': 'assets/pikachu.png'
    };

    Navigator.pushReplacementNamed(context, '/pokemon');
    widget.addProduct(pokmeon);
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Pokemon name is required';
        }

        if (value.length < 3 || value.length > 15) {
          return 'Pokemon name must be between 3 and 15 characters';
        }
      },
      onSaved: (String value) {
        setState(() {
          _name = value;
        });
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(labelText: 'Description'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Pokemon description is required';
        }

        if (value.length < 10 || value.length > 100) {
          return 'Pokemon name must be between 10 and 100 characters';
        }
      },
      onSaved: (String value) {
        setState(() {
          _description = value;
        });
      },
    );
  }

  Widget _buildTypeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Type'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Pokemon type is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'Pokemon name must be between 3 and 20 characters';
        }
      },
      onSaved: (String value) {
        setState(() {
          _type = value;
        });
      },
    );
  }

  Widget _buildHealthField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Starting Health'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Pokemon starting health is required';
        }

        if (!RegExp(r'^\d{0,2}(\.\d{1,2})?$').hasMatch(value)) {
          return 'Pokemon health value must be between 0 and 100';
        }
      },
      onSaved: (String value) {
        setState(() {
          _startingHealth = double.parse(value);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _buildNameField(),
            _buildDescriptionField(),
            _buildTypeField(),
            _buildHealthField(),
            SizedBox(height: 16),
            DarkButton('SAVE', _submitPokemon),
          ],
        ),
      ),
    );
  }
}
