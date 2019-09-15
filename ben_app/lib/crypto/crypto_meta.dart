import 'dart:typed_data';

class KeyValues {
  final Map<String, String> _values;

  KeyValues(this._values);

  String get(String key) => _values[key];

  Uint8List get checksum => null;
}
