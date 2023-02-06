import 'package:collection/collection.dart';

enum Flag {
  nsfw('NSFW'),
  religious('Religious'),
  political('Political'),
  racist('Racist'),
  sexist('Sexist'),
  explicit('Explicit');

  const Flag(this.label);
  final String label;

  static Flag? fromText(String? text) =>
      values.firstWhereOrNull((v) => v.name == text?.toLowerCase());
}
