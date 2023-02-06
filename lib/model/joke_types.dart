import 'package:jokes/model/joke_type.dart';

class JokeTypes {
  JokeTypes();
  final Set<JokeType> _types = JokeType.values.toSet();
  void _addType(JokeType type) {
    _types.add(type);
  }

  void _removeType(JokeType type) {
    if (_types.length == 1) return;
    _types.remove(type);
  }

  void toggleType(JokeType type) {
    if (_types.contains(type)) {
      _removeType(type);
    } else {
      _addType(type);
    }
  }

  bool get oneLiners => _types.contains(JokeType.single);
  bool get twoParts => _types.contains(JokeType.twoPart);
  bool get isDefault => _types.length == JokeType.values.length;

  Map<String, dynamic> get queryParams {
    final Map<String, dynamic> map = {};
    if (isDefault) return map;
    if (_types.contains(JokeType.single)) {
      map['type'] = JokeType.single.name;
    }
    if (_types.contains(JokeType.twoPart)) {
      map['type'] = JokeType.twoPart.name;
    }
    return map;
  }
}
