import 'package:flutter/material.dart';
import 'package:jokes/state/app_state.dart';
import 'package:jokes/widgets/about_ui.dart';
import 'package:jokes/widgets/screen_layout_ui.dart';
import 'package:provider/provider.dart';

class JokePage extends StatelessWidget {
  const JokePage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Media size: ${MediaQuery.of(context).size}');
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jokes'),
        actions: [
          TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const AboutUi(),
                );
              },
              child: const Text('About')),
        ],
      ),
      body: appState.isReady
          ? const ScreenLayoutUi()
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
