import 'package:flutter/material.dart';
import 'package:jokes/model/joke.dart';
import 'package:jokes/model/joke_request.dart';
import 'package:rest_api_client/implementations/rest_api_client.dart';

class JokeState {
  JokeState({
    required RestApiClient apiClient,
    required this.notify,
  }) : _apiClient = apiClient;
  //
  final RestApiClient _apiClient;
  final void Function() notify;
  final JokeRequest request = JokeRequest();
  //
  final Map<int, Joke> _jokes = {};
  int get jokeCount => _jokes.length;
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  //
  List<Joke> get _jokeList {
    final jokes = _jokes.values.toList()
      ..sort((a, b) => b.received.compareTo(a.received));
    return jokes;
  }

  Joke jokeAt({required int index}) => _jokeList[index];

  //
  Future fetch() async {
    _isFetching = true;
    notify();
    try {
      final result = await _apiClient.get(
        request.endPoint,
        queryParameters: request.queryParams,
      );
      Joke? joke;
      if (result.hasData) {
        joke = Joke.fromMap(result.data);
        if (joke == null) throw Exception('No joke received');
        _jokes[joke.id] = joke;
      }
    } catch (e) {
      debugPrint('RLS doh, something went wrong: $e');
    } finally {
      _isFetching = false;
      notify();
    }
  }
}
