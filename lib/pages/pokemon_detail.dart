import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../ui/button_dark.dart';
import '../scoped-models/main.dart';
import '../models/pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final int pokemonIndex;

  PokemonDetail(this.pokemonIndex);

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are you sure?"),
            content: Text("This action cannot be undone!"),
            actions: <Widget>[
              FlatButton(
                child: Text("DISCARD"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("CONTINUE"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          final Pokemon _pokemon = model.pokemonList[pokemonIndex];

          return Scaffold(
            appBar: AppBar(title: Text(_pokemon.name)),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(_pokemon.image, height: 200),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    _pokemon.description,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 32),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[DarkButton('DELETE', () => _showWarningDialog(context))],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
