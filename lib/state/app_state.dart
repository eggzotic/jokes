import 'package:flutter/material.dart';
import 'package:jokes/config/config.dart';
import 'package:jokes/event/event.dart';
import 'package:jokes/model/api_error.dart';
import 'package:jokes/model/joke_error.dart';
import 'package:jokes/state/joke_state.dart';
import 'package:rest_api_client/rest_api_client.dart';

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
      authOptions: null,
    );
    await _apiClient.init();
    _jokeState = JokeState(
      apiClient: _apiClient,
      notify: notifyListeners,
    );
    // listen for errors from the API client
    _apiClient.exceptionHandler.exceptions.stream.listen(_handleError);
    _isReady = true;
    notifyListeners();
  }

  /// Whether there is unacknowledged error-state
  bool get isError => _error != null;

  /// Unacknowledged error state as a result of an API call
  ApiError? get error => _error;
  ApiError? _error;

  void _handleError(BaseException error) {
    if (error is ApiError) {
      _error = error;
      notifyListeners();
    }
    // these builtins below will occur - but they're caught & converted to an
    //  ApiError - and re-added to the stream so that the above catches them
    else if (error is ForbiddenException) {
      debugPrint("RLS Sorry, we're forbidden: $error");
    } else if (error is NetworkErrorException) {
      debugPrint('RLS There was a network error: $error');
    } else if (error is ServerErrorException) {
      debugPrint('RLS There was an error with the server: $error');
    } else if (error is UnauthorizedException) {
      debugPrint("RLS Sorry, we're not authorized: $error");
    } else if (error is ValidationException) {
      debugPrint('RLS Validation errors occurred: $error');
    } else {
      debugPrint('RLS A Base Exception occurred: $error');
    }
  }

  /// Send an Event to the App State
  void sendEvent({required Event event}) {
    if (event is JokeRequestSubmitEvent) {
      _jokeState.fetch();
      // the fetch call above handles notifications asynchronously
      //  so we can return here/now
      return;
    } else if (event is JokeRequestToggleTypeEvent) {
      _jokeState.request.types.toggleType(event.type);
    } else if (event is JokeRequestToggleCategoryEvent) {
      _jokeState.request.categories.toggleCategory(event.category);
    } else if (event is JokeRequestToggleFlagEvent) {
      _jokeState.request.blackList.toggleFlag(event.flag);
    } else if (event is AcknowledgeFetchErrorEvent) {
      // clear the error-state
      _error = null;
    } else if (event is ShareErrorEvent) {
      _apiClient.exceptionHandler.exceptions.add(
        ApiError(
          jokeError: JokeError(
            error: true,
            internalError: false,
            code: 0,
            message: 'Sharing failed',
            causedBy: [],
            additionalInfo: 'The Share dialog is unavailable, sorry',
            timestamp: DateTime.now(),
          ),
        ),
      );
    } else {
      debugPrint('RLS Unknown event received: $event');
      return;
    }
    notifyListeners();
  }
}
