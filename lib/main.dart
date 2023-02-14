import 'package:flutter/material.dart';
import 'package:jokes/state/app_state.dart';
import 'package:jokes/widgets/joke_page.dart';
import 'package:provider/provider.dart';

void main() {
  // this disables debugPrint in production builds
  const bool isProduction = bool.fromEnvironment('dart.vm.product');
  if (isProduction) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(isProd: isProduction),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const JokePage(),
    );
  }
}
