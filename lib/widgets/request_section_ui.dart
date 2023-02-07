import 'package:flutter/material.dart';
import 'package:jokes/event/event.dart';
import 'package:jokes/state/app_state.dart';
import 'package:jokes/widgets/request_categories_ui.dart';
import 'package:jokes/widgets/section_container.dart';
import 'package:jokes/widgets/types_ui.dart';
import 'package:provider/provider.dart';

import 'exclusions_ui.dart';

class RequestSectionUi extends StatelessWidget {
  const RequestSectionUi({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isBusy = !appState.isReady || appState.jokeState.isFetching;
    final again = (appState.isReady ? appState.jokeState.jokeCount : 0) > 0;
    return Column(
      children: [
        const SectionContainer(
          title: 'Categories',
          child: RequestCategoriesUi(titleText: 'Categories'),
        ),
        const Divider(),
        const TypesUi(),
        const Divider(),
        const SectionContainer(
          title: 'Exclude',
          child: ExclusionsUi(),
        ),
        const Divider(),
        Card(
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: ListTile(
            leading: isBusy ? null : const Icon(Icons.bolt_outlined),
            title: isBusy
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Center(
                    child: Text('Make me laugh${again ? ' (again!)' : ''}')),
            onTap: isBusy
                ? null
                : () => appState.sendEvent(event: FetchNewJokeEvent()),
          ),
        ),
      ],
    );
  }
}
