import 'package:flutter/material.dart';

class PokemonDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon Detail"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/gengar.png',
              height: 300,
            ),
            Container(
              child: Text('Details'),
              padding: EdgeInsets.all(16),
            ),
            RaisedButton(
              child: Text(
                'BACK',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              color: Theme.of(context).accentColor,
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
