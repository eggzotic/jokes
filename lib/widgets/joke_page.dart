import 'package:flutter/material.dart';
import 'package:jokes/event/event.dart';
import 'package:jokes/state/app_state.dart';
import 'package:jokes/widgets/joke_list_ui.dart';
import 'package:jokes/widgets/request_categories_ui.dart';
import 'package:jokes/widgets/exclusions_ui.dart';
import 'package:jokes/widgets/types_ui.dart';
import 'package:provider/provider.dart';

class JokePage extends StatelessWidget {
  const JokePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isBusy = !appState.isReady || appState.jokeState.isFetching;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes'),
      ),
      body: appState.isReady
          ? Column(
              children: [
                const ListTile(title: Text('Categories')),
                const RequestCategoriesUi(),
                const Divider(),
                const ListTile(title: Text('Types')),
                const TypesUi(),
                const Divider(),
                const ListTile(title: Text('Exclude')),
                const ExclusionsUi(),
                const Divider(),
                Card(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: ListTile(
                    leading: isBusy ? null : const Icon(Icons.bolt_outlined),
                    title: isBusy
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : const Center(child: Text('Make me laugh')),
                    onTap: isBusy
                        ? null
                        : () => appState.sendEvent(event: FetchNewJokeEvent()),
                    subtitle: isBusy
                        ? null
                        : const Center(
                            child: Text('(Fetch a joke)'),
                          ),
                  ),
                ),
                const Expanded(child: JokeListUi()),
              ],
            )
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
