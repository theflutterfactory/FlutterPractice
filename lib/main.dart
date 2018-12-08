import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{
  List<String> pokemon = ['Gengar'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pokemon"),
        ),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  child: Text('Add Pokemon'),
                  onPressed: (){
                    setState(() {
                      pokemon.add("Mew");
                    });
                  },
                )
            ),
            Column(children: pokemon.map((element) =>Card(
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/gengar.png'),
                      Text(element)
                    ],
                  ),
                )
            )).toList()
            ),
          ],
        )
      )
    );
  }
}
