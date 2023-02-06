import 'package:jokes/model/flag.dart';
import 'package:jokes/model/joke_category.dart';
import 'package:jokes/model/joke_type.dart';

class Event {}

class FetchNewJokeEvent extends Event {}

class JokeRequestToggleType extends Event {
  final JokeType type;
  JokeRequestToggleType(this.type);
}

class JokeRequestToggleCategory extends Event {
  final JokeCategory category;
  JokeRequestToggleCategory(this.category);
}

class JokeRequestToggleFlag extends Event {
  final Flag flag;
  JokeRequestToggleFlag(this.flag);
}
