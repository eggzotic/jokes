import 'package:flutter/material.dart';
import 'package:jokes/model/joke_category.dart';
import 'package:jokes/state/app_state.dart';
import 'package:provider/provider.dart';

import '../event/event.dart';

class RequestCategoriesUi extends StatelessWidget {
  const RequestCategoriesUi({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Row(
      children: JokeCategory.values
          .map((c) => Expanded(
                child: Card(
                  child: CheckboxListTile(
                    title: Text(c.label),
                    value: appState.jokeState.request.categories.includes(c),
                    onChanged: (_) => appState.sendEvent(
                      event: JokeRequestToggleCategory(c),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
