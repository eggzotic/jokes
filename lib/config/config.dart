import 'package:flutter/material.dart';

class Config {
  final appName = 'Jokes Demo';
  final appVersion = '1.0.0';
  final appIcon = Icons.tag_faces_outlined;
  final sourceRepo = 'https://github.com/eggzotic/jokes';
  final appAuthor = 'Richard Shepherd, 2023';
  String get appAbout =>
      'A simple jokes app. Joke data is fetched from $baseUrl';
  //
  final baseUrl = 'https://v2.jokeapi.dev/joke/';
}
