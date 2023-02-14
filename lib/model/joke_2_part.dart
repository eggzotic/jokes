import 'package:jokes/model/flags.dart';
import 'package:jokes/model/joke.dart';
import 'package:json_annotation/json_annotation.dart';

part 'joke_2_part.g.dart';

@JsonSerializable()
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

  factory Joke2Part.fromJson(Map<String, dynamic> json) =>
      _$Joke2PartFromJson(json);
}
