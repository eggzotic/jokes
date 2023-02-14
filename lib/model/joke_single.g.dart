// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_single.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JokeSingle _$JokeSingleFromJson(Map<String, dynamic> json) => JokeSingle(
      error: json['error'] as bool,
      category: json['category'] as String,
      type: json['type'] as String,
      joke: json['joke'] as String,
      flags: Flags.fromJson(json['flags'] as Map<String, dynamic>),
      id: json['id'] as int,
      safe: json['safe'] as bool,
      lang: json['lang'] as String,
    );

Map<String, dynamic> _$JokeSingleToJson(JokeSingle instance) =>
    <String, dynamic>{
      'error': instance.error,
      'category': instance.category,
      'type': instance.type,
      'flags': instance.flags,
      'safe': instance.safe,
      'id': instance.id,
      'lang': instance.lang,
      'joke': instance.joke,
    };
