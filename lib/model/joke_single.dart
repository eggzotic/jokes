import 'package:jokes/model/flags.dart';
import 'package:jokes/model/joke.dart';
import 'package:json_annotation/json_annotation.dart';

part 'joke_single.g.dart';

@JsonSerializable()
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

  factory JokeSingle.fromJson(Map<String, dynamic> json) =>
      _$JokeSingleFromJson(json);
}
