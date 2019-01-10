import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './pokemon_create.dart';
import '../scoped-models/main.dart';
import '../models/pokemon.dart';

class PokemonOwnedPage extends StatefulWidget {
  final MainModel model;

  PokemonOwnedPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _PokemonOwnedPageState();
  }
}

class _PokemonOwnedPageState extends State<PokemonOwnedPage> {
  @override
  initState() {
    widget.model.fetchPokemon(onlyForUser: true);
    super.initState();
  }

  Widget _buildEditButton(BuildContext context, MainModel model, Pokemon pokemon) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectPokemon(pokemon.id);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return PokemonCreatePage();
            },
          ),
        );
      },
    );
  }

  Widget _buildPokemonListItem(BuildContext context, MainModel model, Pokemon pokemon) {
    return Dismissible(
      key: Key(pokemon.name),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        model.selectPokemon(pokemon.id);
        model.deletePokemon();
      },
      background: Container(color: Colors.red),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(pokemon.image),
            ),
            title: Text(pokemon.name),
            subtitle: Text('Health: ${pokemon.startingHealth.toString()}'),
            trailing: _buildEditButton(context, model, pokemon),
          ),
          Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  Pokemon pokemon = model.allpokemon[index];
                  return _buildPokemonListItem(context, model, pokemon);
                },
                itemCount: model.allpokemon.length,
              );
      },
    );
  }
}
