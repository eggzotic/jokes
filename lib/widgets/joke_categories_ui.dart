import 'package:flutter/material.dart';
import 'package:jokes/model/flag.dart';
import 'package:jokes/model/joke.dart';

class JokeCategoriesUi extends StatelessWidget {
  const JokeCategoriesUi({required this.joke, super.key});

  final Joke joke;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
    );
  }
}
