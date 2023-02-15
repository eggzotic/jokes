import 'package:flutter/material.dart';
import 'package:jokes/model/joke.dart';
import 'package:jokes/model/joke_2_part.dart';
import 'package:jokes/model/joke_single.dart';
import 'package:jokes/state/app_state.dart';
import 'package:jokes/widgets/joke_categories_ui.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class JokeTile extends StatelessWidget {
  const JokeTile({
    super.key,
    required this.joke,
  });

  final Joke joke;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isSingle = joke is JokeSingle;
    final is2Part = joke is Joke2Part;
    final textLine1 = isSingle
        ? (joke as JokeSingle).joke
        : is2Part
            ? (joke as Joke2Part).setup
            : 'Unknown Joke type';
    final textLine2 = is2Part ? (joke as Joke2Part).delivery : '';
    return ExpansionTile(
      key: PageStorageKey(ValueKey(joke.id)),
      title: Text(textLine1),
      subtitle: textLine2.isNotEmpty ? Text(textLine2) : null,
      leading: IconButton(
        icon: const Icon(Icons.ios_share_rounded),
        onPressed: () {
          debugPrint('Share pressed, for ID ${joke.id}');
          String text = '';
          if (isSingle) {
            text = textLine1;
          } else if (is2Part) {
            text = 'Q: $textLine1. A: $textLine2';
          }
          text += '\n\nMore jokes at ${appState.config.prodUrl}';
          Share.share(text, subject: 'Joke for you');
        },
      ),
      children: [
        ListTile(
          title: Text('Category: ${joke.category}'),
        ),
        JokeCategoriesUi(joke: joke),
      ],
    );
  }
}
