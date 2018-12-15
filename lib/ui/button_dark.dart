import 'package:flutter/material.dart';

class DarkButton extends StatelessWidget {
  final String buttonText;
  final Function onPressedCallback;

  DarkButton(this.buttonText, this.onPressedCallback);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 120,
      child: RaisedButton(
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        color: Theme.of(context).accentColor,
        onPressed: onPressedCallback,
      ),
    );
  }
}
