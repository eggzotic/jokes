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
    final isWide = MediaQuery.of(context).size.aspectRatio > 2;
    return isWide
        ? Row(
            children: [
              SizedBox(
                width: appState.config.relayoutWidth,
                child: const RequestSectionUi(),
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
  }
}