import 'package:flutter/material.dart';
import 'package:jokes/model/joke_2_part.dart';
import 'package:jokes/model/joke_single.dart';
import 'package:jokes/state/app_state.dart';
import 'package:jokes/widgets/joke_categories_ui.dart';
import 'package:provider/provider.dart';

class JokeListUi extends StatelessWidget {
  const JokeListUi({this.controls, super.key});

  /// Optionally pass in content to display at the beginning of the list
  ///
  /// - This is specifically used for the request-controls being combined
  /// into this ListView when the display is very small
  final Widget? controls;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final withControls = controls != null;
    return ListView.builder(
      itemCount: withControls
          ? appState.jokeState.jokeCount + 1
          : appState.jokeState.jokeCount,
      itemBuilder: (context, index) {
        if (index == 0 && withControls) return controls;
        final jokeNum = withControls ? index - 1 : index;
        final joke = appState.jokeState.jokeAt(index: jokeNum);
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
