import 'package:flutter/material.dart';

class PokemonDetail extends StatelessWidget {
  final String title;
  final String imageUrl;

  PokemonDetail(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Image.asset(imageUrl, height: 300),
              Container(
                child: Text(title),
                padding: EdgeInsets.all(16),
              ),
              ButtonTheme(
                minWidth: 160,
                child: RaisedButton(
                  child: Text(
                    'BACK',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () => Navigator.pop(context, false),
                ),
              ),
              ButtonTheme(
                minWidth: 160,
                child: RaisedButton(
                  child: Text(
                    'DELETE',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () => Navigator.pop(context, true),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
