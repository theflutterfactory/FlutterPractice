import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LOGIN"),
        ),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 32),
              Text(
                "Pokemon Manager",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              SizedBox(height: 32),
              TextField(
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              SizedBox(height: 16),
              RaisedButton(
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/pokemon');
                },
              ),
            ],
          ),
        ));
  }
}
