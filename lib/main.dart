import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pokemon"),
        ),
        body: Column(
          children: [
            Card(
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/gengar.png'),
                      Text('Gengar')
                    ],
                  ),
                )
            ),
          ],
        )
      )
    );
  }
}
