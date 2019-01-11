import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../ui/button_dark.dart';
import '../models/pokemon.dart';
import '../scoped-models/main.dart';
import '../widgets/image_selector.dart';

class PokemonCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PokemonCreatePageState();
  }
}

class _PokemonCreatePageState extends State<PokemonCreatePage> {
  final Pokemon _pokemon = new Pokemon();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showPokemonFeed(MainModel model) {
    Navigator.pushReplacementNamed(context, '/pokemon_feed').then((_) => model.selectPokemon(null));
  }

  void showErrorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Something went wrong"),
            content: Text("Please try again"),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK"),
              )
            ],
          );
        });
  }

  void _submitPokemon(MainModel model) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    if (model.selectedPokemonIndex == -1) {
      model.addPokemon(_pokemon).then((bool success) {
        if (success) {
          _showPokemonFeed(model);
        } else {
          showErrorDialog();
        }
      });
    } else {
      model.updatePokemon(_pokemon).then(
        (bool success) {
          if (success) {
            _showPokemonFeed(model);
          } else {
            showErrorDialog();
          }
        },
      );
    }
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
    Pokemon selectedPokemon = model.selectedPokemon;

    if (selectedPokemon != null) {
      _pokemon.id = selectedPokemon.id;
      _pokemon.userEmail = model.currentUser.email;
      _pokemon.userId = selectedPokemon.userId;
      _pokemon.image = selectedPokemon.image;
    }

    return Container(
      margin: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            _buildNameField(selectedPokemon),
            _buildDescriptionField(selectedPokemon),
            _buildTypeField(selectedPokemon),
            _buildHealthField(selectedPokemon),
            SizedBox(height: 16),
            ImageSelector(),
            SizedBox(height: 16),
            model.isLoading
                ? Center(child: CircularProgressIndicator())
                : DarkButton('SAVE', () => _submitPokemon(model))
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

        return model.selectedPokemonIndex == -1
            ? pageContent
            : Scaffold(
                appBar: AppBar(title: Text("Edit Pokemon")),
                body: pageContent,
              );
      },
    );
  }
}
