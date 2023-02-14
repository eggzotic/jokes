import 'package:flutter_test/flutter_test.dart';
import 'package:jokes/model/flag.dart';

void main() {
  const flag = Flag.nsfw;
  test('Label is NSFW', () {
    expect(flag.label, 'NSFW');
  });
  // test('To JSON', () {
  //   expect(flag., matcher)
  // })
}
