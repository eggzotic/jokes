import 'package:json_annotation/json_annotation.dart';

part 'joke_error.g.dart';

/// Sample input:
/// ```
///  {
///      "error": true,
///      "internalError": false,
///      "code": 106,
///      "message": "No matching joke found",
///      "causedBy": [
///          "No jokes were found that match your provided filter(s)"
///      ],
///      "additionalInfo": "The specified category is invalid - Got: \"foo\" - Possible categories are: \"Any, Misc, Programming, Dark, Pun, Spooky, Christmas\" (case insensitive)",
///      "timestamp": 1579170794412
///   }
/// ```

@JsonSerializable()
class JokeError {
  final bool error;
  final bool internalError;
  final int code;
  final String message;
  final List<String> causedBy;
  final String additionalInfo;
  @JsonKey(fromJson: intToDateTime)
  final DateTime timestamp;

  JokeError({
    required this.error,
    required this.internalError,
    required this.code,
    required this.message,
    required this.causedBy,
    required this.additionalInfo,
    required this.timestamp,
  });

  static DateTime intToDateTime(int secs) =>
      DateTime.fromMillisecondsSinceEpoch(secs * 1000);

  factory JokeError.fromJson(Map<String, dynamic> json) =>
      _$JokeErrorFromJson(json);
}
