import 'package:jokes/model/flags.dart';

abstract class Joke {
  Joke({
    required this.error,
    required this.category,
    required this.type,
    required this.flags,
    required this.safe,
    required this.id,
    required this.lang,
  });

  final bool error;
  final String category;
  final String type;
  final Flags flags;
  final bool safe;
  final int id;
  final String lang;
  final received = DateTime.now();
}
