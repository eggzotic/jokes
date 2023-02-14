import 'package:flutter/material.dart';
import 'package:jokes/model/flag.dart';
import 'package:jokes/model/joke.dart';

class JokeCategoriesUi extends StatelessWidget {
  const JokeCategoriesUi({required this.joke, super.key});

  final Joke joke;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Wrap(
        runSpacing: 4.0,
        alignment: WrapAlignment.center,
        spacing: 4.0,
        children: Flag.values
            .map(
              (f) => FilterChip(
                label: Text(f.label),
                selected: joke.flags.hasFlag(f),
                onSelected: null,
              ),
            )
            .toList(),
      ),
    );
  }
}
