import 'package:jokes/model/flags.dart';
import 'package:jokes/model/query_component.dart';
import 'package:jokes/model/flag.dart';

class FlagState implements QueryComponent {
  FlagState() {
    _addFlag(Flag.explicit);
    _addFlag(Flag.nsfw);
    _addFlag(Flag.racist);
    _addFlag(Flag.sexist);
  }
  final Set<Flag> _flags = {};

  void _addFlag(Flag flag) {
    _flags.add(flag);
  }

  void _removeFlag(Flag flag) {
    _flags.remove(flag);
  }

  void toggleFlag(Flag flag) {
    if (_flags.contains(flag)) {
      _removeFlag(flag);
    } else {
      _addFlag(flag);
    }
  }

  bool isBlackListed(Flag flag) => _flags.contains(flag);

  bool get isDefault => _flags.isEmpty;

  @override
  Map<String, dynamic> get queryParams {
    final Map<String, dynamic> map = {};
    if (isDefault) return map;
    map['blacklistFlags'] = _flags.map((f) => f.name).join(',');
    return map;
  }

  bool get nsfw => _flags.contains(Flag.nsfw);
  bool get religious => _flags.contains(Flag.religious);
  bool get political => _flags.contains(Flag.political);
  bool get racist => _flags.contains(Flag.racist);
  bool get sexist => _flags.contains(Flag.sexist);
  bool get explicit => _flags.contains(Flag.explicit);

  /// Produces a Flags instance representing the current state
  Flags get flags => Flags(
        nsfw: nsfw,
        religious: religious,
        political: political,
        racist: racist,
        sexist: sexist,
        explicit: explicit,
      );
}
