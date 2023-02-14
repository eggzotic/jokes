import 'package:flutter/material.dart';
import 'package:jokes/model/joke.dart';
import 'package:jokes/model/joke_error.dart';
import 'package:jokes/model/joke_request.dart';
import 'package:jokes/model/joke_2_part.dart';
import 'package:jokes/model/joke_single.dart';
import 'package:rest_api_client/implementations/rest_api_client.dart';
import 'package:rest_api_client/models/result.dart';

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

  bool get isError => _error != null;
  void clearError() {
    _error = null;
  }

  JokeError? _error;
  JokeError? get error => _error;

  late Result _result;

  //
  Future fetch() async {
    _isFetching = true;
    notify();
    try {
      _result = await _apiClient.get(
        request.endPoint,
        queryParameters: request.queryParams,
      );
      // error checking
      if (_result.isError) {
        throw Exception('No joke received');
      }
      if (_result.hasData && _result.data['error'] == true) {
        _error = JokeError.fromJson(_result.data);
        notify();
        return;
      }
      // happy-path
      Joke? joke;
      if (_result.hasData) {
        final type = _result.data['type'];
        if (type == 'single') {
          joke = JokeSingle.fromJson(_result.data);
        } else if (type == 'twopart') {
          joke = Joke2Part.fromJson(_result.data);
        }
        if (joke == null) throw Exception('No joke received');
        _jokes[joke.id] = joke;
      }
    } catch (e) {
      debugPrint('RLS doh, something went wrong: $e');
      _error = JokeError(
        error: true,
        internalError: (_result.statusCode ?? 0) >= 500,
        code: _result.statusCode ?? 0,
        message: 'An unexpected error occurred',
        causedBy: [],
        additionalInfo: "We're not sure what happened, sorry",
        timestamp: DateTime.now(),
      );
    } finally {
      _isFetching = false;
      notify();
    }
  }
}
