import 'package:flutter/material.dart';

class Pokemon extends StatelessWidget {
  final List<String> pokemon;

  Pokemon(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: pokemon
            .map((element) => Card(
                color: Theme.of(context).primaryColor,
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/gengar.png'),
                      Text(element,
                          style: TextStyle(color: Colors.white, fontSize: 22)),
                    ],
                  ),
                )))
            .toList());
  }
}
