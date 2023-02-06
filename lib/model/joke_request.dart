import 'package:jokes/model/flags.dart';
import 'package:jokes/model/joke_categories.dart';
import 'package:jokes/model/joke_types.dart';

class JokeRequest {
  JokeRequest();
  final categories = JokeCategories();
  final blackList = Flags();
  final types = JokeTypes();
  //
  String get endPoint => categories.toParams;
  Map<String, dynamic> get queryParams => {
        ...blackList.queryParams,
        ...types.queryParams,
      };
}
