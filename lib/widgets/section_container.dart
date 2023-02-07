import 'package:flutter/material.dart';
import 'package:jokes/state/app_state.dart';
import 'package:provider/provider.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    required this.title,
    required this.child,
    super.key,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return LayoutBuilder(builder: (context, constraints) {
      final isNarrow = constraints.maxWidth <= appState.config.relayoutWidth;
      if (isNarrow) {
        return ExpansionTile(
          key: PageStorageKey(ValueKey(title)),
          title: Text(title),
          children: [child],
        );
      } else {
        return child;
      }
    });
  }
}
