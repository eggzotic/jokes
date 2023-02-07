import 'package:flutter/material.dart';
import 'package:jokes/event/event.dart';
import 'package:jokes/model/joke_category.dart';
import 'package:jokes/state/app_state.dart';
import 'package:provider/provider.dart';

class RequestCategoriesUi extends StatelessWidget {
  const RequestCategoriesUi({required this.titleText,super.key});

  final String titleText;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isNarrow =
        MediaQuery.of(context).size.width <= appState.config.relayoutWidth;
    final title =
        Text(titleText, style: Theme.of(context).textTheme.bodyLarge);
    return ListTile(
      leading: !isNarrow ? title : null,
      title: Wrap(
        runSpacing: 4.0,
        alignment: WrapAlignment.center,
        spacing: 4.0,
        children: JokeCategory.values
            .map(
              (c) => FilterChip(
                label: Text(c.label),
                selected: appState.jokeState.request.categories.includes(c),
                onSelected: (_) => appState.sendEvent(
                  event: JokeRequestToggleCategory(c),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
