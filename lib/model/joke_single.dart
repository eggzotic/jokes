import 'package:jokes/model/flags.dart';
import 'package:jokes/model/joke.dart';

class JokeSingle extends Joke {
  JokeSingle({
    required super.error,
    required super.category,
    required super.type,
    required this.joke,
    required super.flags,
    required super.id,
    required super.safe,
    required super.lang,
  });

  final String joke;

  factory JokeSingle.fromMap(Map<String, dynamic> json) => JokeSingle(
        error: json["error"],
        category: json["category"],
        type: json["type"],
        joke: json["joke"],
        flags: Flags.fromMap(json["flags"]),
        id: json["id"],
        safe: json["safe"],
        lang: json["lang"],
      );

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        "joke": joke,
      };
}
