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
      leading: Text('Types', style: Theme.of(context).textTheme.bodyLarge),
      title: Wrap(
        alignment: WrapAlignment.center,
        spacing: 4.0,
        children: [
          FilterChip(
            label: const Text('One-liners'),
            selected: appState.jokeState.request.types.oneLiners,
            onSelected: (_) => appState.sendEvent(
              event: JokeRequestToggleType(JokeType.single),
            ),
          ),
          FilterChip(
            label: const Text('Two-parts'),
            selected: appState.jokeState.request.types.twoParts,
            onSelected: (_) => appState.sendEvent(
              event: JokeRequestToggleType(JokeType.twoPart),
            ),
          ),
        ],
      ),
    );
  }
}
