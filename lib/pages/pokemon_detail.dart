import 'package:flutter/material.dart';

import '../ui/button_dark.dart';
import '../models/pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetail(this.pokemon);

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
      child: Scaffold(
        appBar: AppBar(title: Text(pokemon.name)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 16),
            Image.network(pokemon.image, height: 200),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                pokemon.description,
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
      ),
    );
  }
}
