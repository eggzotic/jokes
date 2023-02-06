import 'package:flutter/material.dart';
import 'package:jokes/model/joke_2_part.dart';
import 'package:jokes/model/joke_single.dart';
import 'package:jokes/state/app_state.dart';
import 'package:jokes/widgets/joke_categories_ui.dart';
import 'package:provider/provider.dart';

class JokeListUi extends StatelessWidget {
  const JokeListUi({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return ListView.builder(
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
          subtitle: (joke is Joke2Part) ? Text(joke.delivery) : null,
          children: [
            ListTile(
              title: Text('Category: ${joke.category}'),
            ),
            JokeCategoriesUi(joke: joke),
          ],
        );
      },
    );
  }
}
