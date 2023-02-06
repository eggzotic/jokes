import 'package:flutter/material.dart';
import 'package:jokes/event/event.dart';
import 'package:jokes/model/flag.dart';
import 'package:jokes/model/joke_2_part.dart';
import 'package:jokes/model/joke_category.dart';
import 'package:jokes/model/joke_single.dart';
import 'package:jokes/model/joke_type.dart';
import 'package:jokes/state/app_state.dart';
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
                Row(
                  children: JokeCategory.values
                      .map((c) => Expanded(
                            child: Card(
                              child: CheckboxListTile(
                                title: Text(c.label),
                                value: appState.jokeState.request.categories
                                    .includes(c),
                                onChanged: (_) => appState.sendEvent(
                                  event: JokeRequestToggleCategory(c),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const Divider(),
                const ListTile(title: Text('Types')),
                ListTile(
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
                ),
                const Divider(),
                const ListTile(title: Text('Exclude')),
                Row(
                  children: Flag.values
                      .map(
                        (f) => Expanded(
                          child: Card(
                            child: CheckboxListTile(
                              title: Text(f.label),
                              value: appState.jokeState.request.blackList
                                  .isBlackListed(f),
                              onChanged: (_) => appState.sendEvent(
                                event: JokeRequestToggleFlag(f),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
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
                Expanded(
                  child: ListView.builder(
                    itemCount: appState.jokeState.jokeCount,
                    itemBuilder: (context, index) {
                      final joke = appState.jokeState.jokeAt(index: index);
                      return ExpansionTile(
                        key: PageStorageKey(ValueKey(joke.id)),
                        title: Text((joke is JokeSingle)
                            ? joke.joke
                            : (joke is Joke2Part)
                                ? joke.setup
                                : 'Unknown Joke type'),
                        subtitle:
                            (joke is Joke2Part) ? Text(joke.delivery) : null,
                        children: [
                          ListTile(
                            title: Text('Category: ${joke.category}'),
                          ),
                          ListTile(
                            title: Row(
                              children: Flag.values
                                  .map(
                                    (f) => Expanded(
                                      child: Card(
                                        child: CheckboxListTile(
                                          title: Text(f.label),
                                          value: joke.flags.isBlackListed(f),
                                          onChanged: null,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
