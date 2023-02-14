// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_2_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Joke2Part _$Joke2PartFromJson(Map<String, dynamic> json) => Joke2Part(
      error: json['error'] as bool,
      category: json['category'] as String,
      type: json['type'] as String,
      setup: json['setup'] as String,
      delivery: json['delivery'] as String,
      flags: Flags.fromJson(json['flags'] as Map<String, dynamic>),
      safe: json['safe'] as bool,
      id: json['id'] as int,
      lang: json['lang'] as String,
    );

Map<String, dynamic> _$Joke2PartToJson(Joke2Part instance) => <String, dynamic>{
      'error': instance.error,
      'category': instance.category,
      'type': instance.type,
      'flags': instance.flags,
      'safe': instance.safe,
      'id': instance.id,
      'lang': instance.lang,
      'setup': instance.setup,
      'delivery': instance.delivery,
    };
