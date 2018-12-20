import 'package:flutter/material.dart';

import './pokemon_create.dart';
import '../data/pokemon.dart';

class PokemonOwnedPage extends StatelessWidget {
  final Function updatePokemon;
  final Function deletePokemon;
  final List<Pokemon> pokemonList;

  PokemonOwnedPage(this.pokemonList, this.updatePokemon, this.deletePokemon);

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PokemonCreatePage(
              pokemon: pokemonList[index],
              updatePokemon: updatePokemon,
              pokemonIndex: index,
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(pokemonList[index].name),
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            deletePokemon(index);
          },
          background: Container(color: Colors.red),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(pokemonList[index].image),
                ),
                title: Text(pokemonList[index].name),
                subtitle: Text('Health: ${pokemonList[index].startingHealth.toString()}'),
                trailing: _buildEditButton(context, index),
              ),
              Divider()
            ],
          ),
        );
      },
      itemCount: pokemonList.length,
    );
  }
}
