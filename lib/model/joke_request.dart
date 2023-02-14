import 'package:jokes/model/joke_categories.dart';
import 'package:jokes/model/joke_types.dart';
import 'package:jokes/state/flag_state.dart';

class JokeRequest {
  JokeRequest();
  final categories = JokeCategories();
  final blackList = FlagState();
  final types = JokeTypes();
  //
  String get endPoint => categories.toParams;
  Map<String, dynamic> get queryParams => {
        ...blackList.queryParams,
        ...types.queryParams,
      };
}
