import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../ui/button_dark.dart';
import '../models/pokemon.dart';
import '../scoped-models/main.dart';

class PokemonCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PokemonCreatePageState();
  }
}

class _PokemonCreatePageState extends State<PokemonCreatePage> {
  final Pokemon _pokemon = new Pokemon();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitPokemon(MainModel mainModel) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    if (mainModel.selectedPokemonIndex == null) {
      mainModel.addPokemon(_pokemon);
    } else {
      mainModel.updatePokemon(_pokemon);
    }

    Navigator.pushReplacementNamed(context, '/pokemon_feed')
        .then((_) => mainModel.selectPokemon(null));
  }

  Widget _buildNameField(Pokemon pokemon) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      initialValue: pokemon == null ? '' : pokemon.name,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Pokemon name is required';
        }

        if (value.length < 3 || value.length > 15) {
          return 'Pokemon name must be between 3 and 15 characters';
        }
      },
      onSaved: (String value) {
        _pokemon.name = value;
      },
    );
  }

  Widget _buildDescriptionField(Pokemon pokemon) {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(labelText: 'Description'),
      initialValue: pokemon == null ? '' : pokemon.description,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Pokemon description is required';
        }

        if (value.length < 10 || value.length > 100) {
          return 'Pokemon name must be between 10 and 100 characters';
        }
      },
      onSaved: (String value) {
        _pokemon.description = value;
      },
    );
  }

  Widget _buildTypeField(Pokemon pokemon) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Type'),
      initialValue: pokemon == null ? '' : pokemon.type,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Pokemon type is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'Pokemon name must be between 3 and 20 characters';
        }
      },
      onSaved: (String value) {
        _pokemon.type = value;
      },
    );
  }

  Widget _buildHealthField(Pokemon pokemon) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Starting Health'),
      initialValue: pokemon == null ? '' : pokemon.startingHealth.toString(),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Pokemon starting health is required';
        }

        if (!RegExp(r'^\d{0,2}(\.\d{1,2})?$').hasMatch(value)) {
          return 'Pokemon health value must be between 0 and 100';
        }
      },
      onSaved: (String value) {
        _pokemon.startingHealth = double.parse(value);
      },
    );
  }

  Widget _buildPageContent(MainModel model) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _buildNameField(model.selectedPokemon),
            _buildDescriptionField(model.selectedPokemon),
            _buildTypeField(model.selectedPokemon),
            _buildHealthField(model.selectedPokemon),
            SizedBox(height: 16),
            DarkButton('SAVE', () => _submitPokemon(model))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent = _buildPageContent(model);

        return model.selectedPokemonIndex == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(title: Text("Edit Pokemon")),
                body: pageContent,
              );
      },
    );
  }
}
