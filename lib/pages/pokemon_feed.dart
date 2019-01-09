import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-models/main.dart';
import '../widgets/pokemon_list.dart';
import '../ui/logout_list_tile.dart';

class PokemonFeed extends StatefulWidget {
  final MainModel model;

  PokemonFeed(this.model);
  @override
  State<StatefulWidget> createState() {
    return _PokemonFeedState();
  }
}

class _PokemonFeedState extends State<PokemonFeed> {
  @override
  initState() {
    widget.model.fetchPokemon(true);
    super.initState();
  }

  Widget _buildSideDrawer(BuildContext context, MainModel model) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text(model.currentUser.email),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Pokemon'),
            onTap: () => Navigator.pushReplacementNamed(context, '/admin'),
          ),
          LogoutListTile(model)
        ],
      ),
    );
  }

  Widget _buildPokemonList() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(child: Text("No Pokemon Found!"));

      if (model.displayedPokemon.length > 0 && !model.isLoading) {
        content = PokemonList();
      } else if (model.isLoading) {
        content = Center(child: CircularProgressIndicator());
      }

      return RefreshIndicator(
        child: content,
        onRefresh: () => model.fetchPokemon(false),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          drawer: _buildSideDrawer(context, model),
          appBar: AppBar(
            title: Text("Pokemon"),
            actions: <Widget>[
              IconButton(
                icon: Icon(model.displayFavoritesOnly ? Icons.favorite : Icons.favorite_border),
                onPressed: () => model.toggleDisplayMode(),
              )
            ],
          ),
          body: _buildPokemonList(),
        );
      },
    );
  }
}
