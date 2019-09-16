import 'dart:typed_data';

class KeyValues {
  final Map<String, String> _values;

  KeyValues(this._values);

  String get(String key) => _values[key];

  Uint8List get checksum => null;
}

abstract class EncryptionMeta {
  String getVersion();

  String getMasterSeed();

  String getHashSeed();
}

class AppHeaders extends KeyValues {
  AppHeaders(Map<String, String> values) : super(values);
}
