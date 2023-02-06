import 'package:flutter/material.dart';
import 'package:jokes/event/event.dart';
import 'package:jokes/model/joke_type.dart';
import 'package:jokes/state/app_state.dart';
import 'package:provider/provider.dart';

class TypesUi extends StatelessWidget {
  const TypesUi({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Card(
              child: CheckboxListTile(
                title: const Text('One-liners'),
                value: appState.jokeState.request.types.oneLiners,
                onChanged: (_) => appState.sendEvent(
                  event: JokeRequestToggleType(JokeType.single),
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: CheckboxListTile(
                title: const Text('Two-parts'),
                value: appState.jokeState.request.types.twoParts,
                onChanged: (_) => appState.sendEvent(
                  event: JokeRequestToggleType(JokeType.twoPart),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
