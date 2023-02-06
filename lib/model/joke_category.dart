enum JokeCategory {
  any('Any'),
  programming('Programming'),
  miscellaneous('Misc'),
  dark('Dark'),
  pun('Pun'),
  spooky('Spooky'),
  christmas('Christmas');

  final String label;
  const JokeCategory(this.label);
}
