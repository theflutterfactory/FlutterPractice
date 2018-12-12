import 'package:flutter/material.dart';

class PokemonList extends StatelessWidget {
  final List<Map<String, dynamic>> pokemonList;

  PokemonList(this.pokemonList);

  Widget _buildPokemonItem(BuildContext context, int index) {
    return Card(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(16),
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                pokemonList[index]['name'],
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              Image.asset(pokemonList[index]['image'], height: 150),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text("Details", style: TextStyle(color: Colors.white, fontSize: 16)),
                    color: Theme.of(context).accentColor,
                    onPressed: () =>
                        Navigator.pushNamed<bool>(context, '/pokemon/' + index.toString()),
                  )
                ],
              )
            ],
          )),
    );
  }

  Widget _buildPokemonList() {
    Widget pokemonCard = Center(
      child: Text("No Pokemon found, Go ahead and add one"),
    );

    if (pokemonList.length > 0) {
      pokemonCard = ListView.builder(
        itemBuilder: _buildPokemonItem,
        itemCount: pokemonList.length,
      );
    }
    return pokemonCard;
  }

  @override
  Widget build(BuildContext context) {
    return _buildPokemonList();
  }
}
