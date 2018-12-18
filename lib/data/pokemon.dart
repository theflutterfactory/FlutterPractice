class Pokemon {
  String name;
  String description;
  String type;
  double startingHealth;
  String image = 'assets/pikachu.png';

  Pokemon();

  Pokemon.create(this.name, this.description, this.type, this.startingHealth, this.image);
}
