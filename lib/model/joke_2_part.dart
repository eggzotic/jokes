import 'package:jokes/model/flags.dart';
import 'package:jokes/model/joke.dart';

class Joke2Part extends Joke {
  Joke2Part({
    required super.error,
    required super.category,
    required super.type,
    required this.setup,
    required this.delivery,
    required super.flags,
    required super.safe,
    required super.id,
    required super.lang,
  });

  final String setup;
  final String delivery;

  factory Joke2Part.fromMap(Map<String, dynamic> json) => Joke2Part(
        error: json["error"],
        category: json["category"],
        type: json["type"],
        setup: json["setup"],
        delivery: json["delivery"],
        flags: Flags.fromMap(json["flags"]),
        safe: json["safe"],
        id: json["id"],
        lang: json["lang"],
      );

  @override
  Map<String, dynamic> toMap() => {
        ...super.toMap(),
        "setup": setup,
        "delivery": delivery,
      };
}
