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
    final isNarrow =
        MediaQuery.of(context).size.width <= appState.config.relayoutWidth;
    final title = Text('Exclude', style: Theme.of(context).textTheme.bodyLarge);
    return ListTile(
      leading: !isNarrow ? title : null,
      title: Wrap(
        runSpacing: 4.0,
        alignment: WrapAlignment.center,
        spacing: 4.0,
        children: Flag.values
            .map(
              (f) => FilterChip(
                label: Text(f.label),
                selected: appState.jokeState.request.blackList.isBlackListed(f),
                onSelected: (_) => appState.sendEvent(
                  event: JokeRequestToggleFlag(f),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
