import 'package:flutter/material.dart';

import './pokemon.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LOGIN"),
        ),
        body: Center(
          child: RaisedButton(
            child: Text("Login"),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Pokemon()),
              );
            },
          ),
        ));
  }
}
