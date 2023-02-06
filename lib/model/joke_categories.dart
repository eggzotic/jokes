import 'package:jokes/model/joke_category.dart';

class JokeCategories {
  final Set<JokeCategory> _categories = {JokeCategory.any};

  void _addCategory(JokeCategory category) {
    _categories.remove(JokeCategory.any);
    if (category == JokeCategory.any) {
      _categories.clear();
      _categories.add(category);
      return;
    }
    _categories.add(category);
  }

  void _removeCategory(JokeCategory category) {
    _categories.remove(category);
    if (_categories.isEmpty) {
      _categories.add(JokeCategory.any);
    }
  }

  void toggleCategory(JokeCategory category) {
    if (_categories.contains(category)) {
      _removeCategory(category);
    } else {
      _addCategory(category);
    }
  }

  bool includes(JokeCategory category) => _categories.contains(category);

  String get toParams => _categories.map((c) => c.name).join(',');
}
