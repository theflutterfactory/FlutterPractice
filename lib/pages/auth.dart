import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _email;
  String _password;
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Image.asset('assets/pikachu.png', height: 160),
                Text(
                  "Pokemon Manager",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: 32),
                TextField(
                  decoration: InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                SwitchListTile(
                  value: _acceptTerms,
                  title: Text('Accept Terms'),
                  onChanged: (bool value) {
                    setState(() {
                      _acceptTerms = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                RaisedButton(
                  child: Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/pokemon');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
