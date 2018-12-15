import 'package:flutter/material.dart';

import '../ui/button_dark.dart';

class PokemonDetail extends StatelessWidget {
  final String title;
  final String imageUrl;

  PokemonDetail(this.title, this.imageUrl);

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
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Column(
            children: <Widget>[
              Image.asset(imageUrl, height: 300),
              Container(child: Text(title), padding: EdgeInsets.all(16)),
              DarkButton('BACK', () => Navigator.pop(context, false)),
              DarkButton('DELETE', () => _showWarningDialog(context)),
            ],
          ),
        ),
      ),
    );
  }
}
