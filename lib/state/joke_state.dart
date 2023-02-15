import 'package:jokes/model/api_error.dart';
import 'package:jokes/model/joke.dart';
import 'package:jokes/model/joke_error.dart';
import 'package:jokes/model/joke_request.dart';
import 'package:jokes/model/joke_2_part.dart';
import 'package:jokes/model/joke_single.dart';
import 'package:rest_api_client/rest_api_client.dart';

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
      if (_result.isError) throw ApiError(error: _result.exception!);

      if (_result.hasData) {
        if (_result.data['error'] == true) {
          throw ApiError(jokeError: JokeError.fromJson(_result.data));
        } else {
          // happy-path
          Joke? joke;
          final type = _result.data['type'];
          if (type == 'single') {
            joke = JokeSingle.fromJson(_result.data);
          } else if (type == 'twopart') {
            joke = Joke2Part.fromJson(_result.data);
          }
          if (joke == null) {
            throw ApiError(error: Exception('No joke received'));
          }
          _jokes[joke.id] = joke;
        }
      }
    } catch (e) {
      final apiError = (e is ApiError) ? e : ApiError(error: e);
      // add to the exceptions stream - and let the listener handle it
      _apiClient.exceptionHandler.exceptions.add(apiError);
    } finally {
      _isFetching = false;
      notify();
    }
  }
}
