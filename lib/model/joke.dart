import 'package:jokes/model/flags.dart';
import 'package:jokes/model/joke_2_part.dart';
import 'package:jokes/model/joke_single.dart';

abstract class Joke {
  Joke({
    required this.error,
    required this.category,
    required this.type,
    required this.flags,
    required this.safe,
    required this.id,
    required this.lang,
  });

  final bool error;
  final String category;
  final String type;
  final Flags flags;
  final bool safe;
  final int id;
  final String lang;
  final received = DateTime.now();

  static Joke? fromMap(Map<String, dynamic> map) {
    if (map['type'] == 'single') return JokeSingle.fromMap(map);
    if (map['type'] == 'twopart') return Joke2Part.fromMap(map);
    return null;
  }

  Map<String, dynamic> toMap() => {
        "error": error,
        "category": category,
        "type": type,
        "flags": flags.toMap(),
        "safe": safe,
        "id": id,
        "lang": lang,
      };
}
