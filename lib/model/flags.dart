import 'package:jokes/model/flag.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flags.g.dart';

/// Sample JSON
/// "flags": {
///        "nsfw": false,
///        "religious": false,
///        "political": false,
///        "racist": false,
///        "sexist": false,
///        "explicit": false
///    }

@JsonSerializable()
class Flags {
  final bool nsfw;
  final bool religious;
  final bool political;
  final bool racist;
  final bool sexist;
  final bool explicit;

  Flags({
    required this.nsfw,
    required this.religious,
    required this.political,
    required this.racist,
    required this.sexist,
    required this.explicit,
  });

  bool hasFlag(Flag flag) {
    switch (flag) {
      case Flag.explicit:
        return explicit;
      case Flag.nsfw:
        return nsfw;
      case Flag.political:
        return political;
      case Flag.racist:
        return racist;
      case Flag.religious:
        return religious;
      case Flag.sexist:
        return sexist;
    }
  }

  factory Flags.fromJson(Map<String, dynamic> json) =>
      _$FlagsFromJson(json);
}
