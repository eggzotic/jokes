import 'package:flutter/material.dart';
import 'package:jokes/state/app_state.dart';
import 'package:jokes/widgets/joke_list_ui.dart';
import 'package:jokes/widgets/request_section_ui.dart';
import 'package:provider/provider.dart';

class ScreenLayoutUi extends StatelessWidget {
  const ScreenLayoutUi({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth / constraints.maxHeight >
            appState.config.wideLayoutAspect;
        final isSmall =
            constraints.maxHeight < appState.config.relayoutHeight &&
                constraints.maxWidth < appState.config.relayoutWidth;
        if (isSmall) return const JokeListUi(controls: RequestSectionUi());
        return isWide
            ? Row(
                children: [
                  SizedBox(
                    width: appState.config.relayoutWidth - 100,
                    child: ListView(children: const [RequestSectionUi()]),
                  ),
                  const Expanded(child: JokeListUi())
                ],
              )
            : const Column(
                children: [
                  RequestSectionUi(),
                  Expanded(child: JokeListUi()),
                ],
              );
      },
    );
  }
}
