import 'package:jokes/model/flag.dart';

class Flags {
  factory Flags() {
    return Flags.fromFlags(flags: [
      Flag.explicit,
      Flag.racist,
      Flag.nsfw,
      Flag.sexist,
    ]);
  }
  Flags.fromBool({
    required bool nsfw,
    required bool religious,
    required bool political,
    required bool racist,
    required bool sexist,
    required bool explicit,
  }) {
    if (nsfw) _addFlag(Flag.nsfw);
    if (religious) _addFlag(Flag.religious);
    if (political) _addFlag(Flag.political);
    if (racist) _addFlag(Flag.racist);
    if (sexist) _addFlag(Flag.sexist);
    if (explicit) _addFlag(Flag.explicit);
  }

  bool get nsfw => _flags.contains(Flag.nsfw);
  bool get religious => _flags.contains(Flag.religious);
  bool get political => _flags.contains(Flag.political);
  bool get racist => _flags.contains(Flag.racist);
  bool get sexist => _flags.contains(Flag.sexist);
  bool get explicit => _flags.contains(Flag.explicit);

  bool isBlackListed(Flag flag) => _flags.contains(flag);

  Flags.fromFlags({required Iterable<Flag> flags}) {
    _flags.clear();
    _flags.addAll(flags.toSet());
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

  factory Flags.fromMap(Map<String, dynamic> json) => Flags.fromBool(
        nsfw: json["nsfw"],
        religious: json["religious"],
        political: json["political"],
        racist: json["racist"],
        sexist: json["sexist"],
        explicit: json["explicit"],
      );

  bool get isDefault => _flags.isEmpty;

  Map<String, dynamic> get queryParams {
    final Map<String, dynamic> map = {};
    if (isDefault) return map;
    map['blacklistFlags'] = _flags.map((f) => f.name).join(',');
    return map;
  }

  Map<String, dynamic> toMap() => {
        "nsfw": nsfw,
        "religious": religious,
        "political": political,
        "racist": racist,
        "sexist": sexist,
        "explicit": explicit,
      };
}
