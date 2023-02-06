import 'package:flutter/material.dart';
import 'package:jokes/event/event.dart';
import 'package:jokes/model/flag.dart';
import 'package:jokes/state/app_state.dart';
import 'package:provider/provider.dart';

class ExclusionsUi extends StatelessWidget {
  const ExclusionsUi({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Row(
      children: Flag.values
          .map(
            (f) => Expanded(
              child: Card(
                child: CheckboxListTile(
                  title: Text(f.label),
                  value: appState.jokeState.request.blackList.isBlackListed(f),
                  onChanged: (_) => appState.sendEvent(
                    event: JokeRequestToggleFlag(f),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
