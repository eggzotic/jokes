import 'package:flutter/material.dart';
import 'package:jokes/model/joke_error.dart';
import 'package:rest_api_client/rest_api_client.dart';

class ApiError extends BaseException {
  final dynamic error;
  final JokeError? jokeError;
  //
  late final int code;
  bool get internalError => code >= 500;
  late final String message;
  late final String additionalInfo;

  ApiError({this.error, this.jokeError}) {
    int code = 0;
    String message = 'An unexpected error occurred';
    String additionalInfo = "We're not sure what happened, sorry";
    if (jokeError != null) {
      code = jokeError!.code;
      message = jokeError!.message;
      additionalInfo = jokeError!.additionalInfo;
    } else if (error is DioError) {
      final e = error as DioError;
      debugPrint('RLS DioError Occurred');
      code = e.response?.statusCode ?? 0;
      message = 'Type: ${e.type.name}';
      additionalInfo = e.message;
    }
    this.code = code;
    this.message = message;
    this.additionalInfo = additionalInfo;
  }
}
