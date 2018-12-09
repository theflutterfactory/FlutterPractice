import 'package:flutter/material.dart';

class Pokemon extends StatelessWidget {
  final List<String> pokemonList;

  Pokemon(this.pokemonList);

  Widget _buildPokemonItem(BuildContext context, int index) {
    return Card(
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Image.asset('assets/gengar.png'),
            Text(pokemonList[index], style: TextStyle(color: Colors.white, fontSize: 22))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildPokemonItem,
      itemCount: pokemonList.length,
    );
  }
}
