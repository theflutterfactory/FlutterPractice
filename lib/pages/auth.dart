import 'package:flutter/material.dart';

import '../ui/button_dark.dart';
import '../data/authInfo.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final AuthInfo _authInfo = new AuthInfo();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _login() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    Navigator.pushReplacementNamed(context, '/pokemon_feed');
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
      },
      onSaved: (String value) {
        _authInfo.email = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Password"),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required';
        }

        if (value.length < 10 || value.length > 50) {
          return 'Password must be betweem 10 and 50 characters';
        }
      },
      onSaved: (String value) {
        _authInfo.password = value;
      },
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _authInfo.acceptTerms,
      onChanged: (bool value) {
        setState(() {
          _authInfo.acceptTerms = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LOGIN")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Image.asset('assets/pikachu.png', height: 160),
                Text(
                  "Pokemon Manager",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(height: 32),
                _buildEmailField(),
                _buildPasswordField(),
                SizedBox(height: 16),
                _buildAcceptSwitch(),
                SizedBox(height: 16),
                DarkButton('LOGIN', _login),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
