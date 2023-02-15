import 'package:jokes/model/joke_category.dart';
import 'package:jokes/model/joke_type.dart';
import 'package:jokes/model/flag.dart';

class Event {}

class JokeRequestSubmitEvent extends Event {}

class JokeRequestToggleTypeEvent extends Event {
  final JokeType type;
  JokeRequestToggleTypeEvent(this.type);
}

class JokeRequestToggleCategoryEvent extends Event {
  final JokeCategory category;
  JokeRequestToggleCategoryEvent(this.category);
}

class JokeRequestToggleFlagEvent extends Event {
  final Flag flag;
  JokeRequestToggleFlagEvent(this.flag);
}

class AcknowledgeFetchErrorEvent extends Event {}

class ShareErrorEvent extends Event {}
