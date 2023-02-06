import 'package:flutter/material.dart';
import 'package:jokes/state/app_state.dart';
import 'package:provider/provider.dart';

class AboutUi extends StatelessWidget {
  const AboutUi({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return AboutDialog(
      applicationName: appState.config.appName,
      applicationIcon: Icon(appState.config.appIcon),
      applicationVersion: appState.config.appVersion,
      children: [
        ListTile(
          title: Text(appState.config.appAbout),
        ),
        ListTile(
          title: Text(appState.config.sourceRepo),
          subtitle: const Text('Application source code repo'),
        ),
        ListTile(
          title: Text(appState.config.appAuthor),
        )
      ],
    );
  }
}
