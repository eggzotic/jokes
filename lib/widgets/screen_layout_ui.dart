import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:jokes/event/event.dart';
import 'package:jokes/state/app_state.dart';
import 'package:jokes/widgets/joke_list_ui.dart';
import 'package:jokes/widgets/request_section_ui.dart';
import 'package:provider/provider.dart';

class ScreenLayoutUi extends StatelessWidget {
  const ScreenLayoutUi({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    if (appState.jokeState.isError) {
      final error = appState.jokeState.error!;
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          showPlatformDialog(
            context: context,
            builder: (_) => BasicDialogAlert(
              title: const Text('Error'),
              content: Column(
                children: [
                  ListTile(
                    title: Text(error.message),
                  ),
                  ListTile(
                    title: Text(error.additionalInfo),
                  ),
                  if (error.internalError)
                    const ListTile(
                      title: Text("This was a server-error - don't stress it"),
                    ),
                  ListTile(
                    title: Text('${error.code}'),
                    subtitle: const Text('Error code'),
                  ),
                ],
              ),
              actions: [
                BasicDialogAction(
                  title: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          ).then(
              (_) => appState.sendEvent(event: AcknowledgeFetchErrorEvent()));
        },
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth / constraints.maxHeight >
            appState.config.wideLayoutAspect;
        final isSmall =
            constraints.maxHeight < appState.config.relayoutHeight &&
                constraints.maxWidth < appState.config.relayoutWidth;
        if (isSmall) return const JokeListUi(controls: RequestSectionUi());
        if (isWide) {
          return Row(
            children: [
              SizedBox(
                width: appState.config.relayoutWidth - 100,
                child: ListView(children: const [RequestSectionUi()]),
              ),
              const Expanded(child: JokeListUi())
            ],
          );
        }
        return const Column(
          children: [
            RequestSectionUi(),
            Expanded(child: JokeListUi()),
          ],
        );
      },
    );
  }
}
