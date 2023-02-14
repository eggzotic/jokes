// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JokeError _$JokeErrorFromJson(Map<String, dynamic> json) => JokeError(
      error: json['error'] as bool,
      internalError: json['internalError'] as bool,
      code: json['code'] as int,
      message: json['message'] as String,
      causedBy:
          (json['causedBy'] as List<dynamic>).map((e) => e as String).toList(),
      additionalInfo: json['additionalInfo'] as String,
      timestamp: JokeError.intToDateTime(json['timestamp'] as int),
    );

Map<String, dynamic> _$JokeErrorToJson(JokeError instance) => <String, dynamic>{
      'error': instance.error,
      'internalError': instance.internalError,
      'code': instance.code,
      'message': instance.message,
      'causedBy': instance.causedBy,
      'additionalInfo': instance.additionalInfo,
      'timestamp': instance.timestamp.toIso8601String(),
    };
