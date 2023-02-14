import 'package:flutter/material.dart';
import 'package:jokes/config/config.dart';
import 'package:jokes/event/event.dart';
import 'package:jokes/state/joke_state.dart';
import 'package:rest_api_client/implementations/rest_api_client.dart';
import 'package:rest_api_client/options/logging_options.dart';
import 'package:rest_api_client/options/rest_api_client_options.dart';

class AppState with ChangeNotifier {
  AppState({required this.isProd}) {
    _init();
  }

  final bool isProd;
  late final RestApiClient _apiClient;
  final config = Config();

  bool _isReady = false;
  bool get isReady => _isReady;

  late final JokeState _jokeState;
  JokeState get jokeState => _jokeState;

  void _init() async {
    await RestApiClient.initFlutter();
    _apiClient = RestApiClient(
      options: RestApiClientOptions(baseUrl: config.baseUrl),
      loggingOptions: LoggingOptions(
        logNetworkTraffic: !isProd,
        request: true,
        requestBody: false,
        requestHeader: false,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: false,
      ),
    );
    await _apiClient.init();
    _jokeState = JokeState(
      apiClient: _apiClient,
      notify: notifyListeners,
    );
    _isReady = true;
    notifyListeners();
  }

  //
  /// Send an Event to the App State
  void sendEvent({required Event event}) {
    if (event is JokeRequestSubmitEvent) {
      _jokeState.fetch();
      return;
    } else if (event is JokeRequestToggleTypeEvent) {
      _jokeState.request.types.toggleType(event.type);
    } else if (event is JokeRequestToggleCategoryEvent) {
      _jokeState.request.categories.toggleCategory(event.category);
    } else if (event is JokeRequestToggleFlagEvent) {
      _jokeState.request.blackList.toggleFlag(event.flag);
    } else if (event is AcknowledgeFetchErrorEvent) {
      _jokeState.clearError();
    } else {
      debugPrint('RLS Unknown event received: $event');
      return;
    }
    notifyListeners();
  }
}
