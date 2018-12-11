import 'package:flutter/material.dart';

import './pages/pokemonDetail.dart';

class PokemonList extends StatelessWidget {
  final List<Map<String, String>> pokemonList;

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
                pokemonList[index]['title'],
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              Image.asset(pokemonList[index]['image'], height: 150),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text("Details", style: TextStyle(color: Colors.white, fontSize: 16)),
                    color: Theme.of(context).accentColor,
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PokemonDetail(
                                  pokemonList[index]['title'],
                                  pokemonList[index]['image'],
                                ),
                          ),
                        ),
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
