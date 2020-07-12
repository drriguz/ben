/*
  <masterPassword>       = 1125482715
  <masterPasswordHash>   = sha256(sha256(<masterPassword>))
  <transformedMasterKey> = argon2d(2, 1024, <masterPasswordHash>, <transformSeed>)
  <headerHashKey>        = sha512(<masterSeed> + <transformedMasterKey>)
  <itemHashKey>          = sha512(<itemId> + <transformedMasterKey>)
 */
import 'dart:convert';
import 'dart:typed_data';

import 'package:ben_app/crypto/hmac_validator.dart';

class Header with Hashable {
  int _type;
  String _value;

  int get type => _type;

  String get value => _value;

  Header(int type, String value) {
    assert(value != null);
    _type = type;
    _value = value;
  }

  @override
  Uint8List getSources() {
    return utf8.encode("$_type:$_value");
  }
}

class Headers {
  static const int CHECKSUM = 0;
  static const int VERSION = 1;
  static const int CIPHER_ID = 2;
  static const int COMPRESSION_FLAGS = 3;
  static const int MASTER_SEED = 4;
  static const int TRANSFORM_SEED = 5;
  static const int ENCRYPTION_IV = 6;
  static const int KDF_PARAMETERS = 7;

  static const String AES = "31c1f2e6bf714350be5805216afc5aff";
  static const String NO_COMPRESSION = "No";

  final Map<int, Header> _headers;

  Headers.from(List<Header> headers) : _headers = Map() {
    headers.forEach((h) => {_headers[h.type] = h});
  }

  String getValue(int type) {
    return _headers[type]?.value;
  }

  String get checksum => getValue(CHECKSUM);

  String get version => getValue(VERSION);

  String get cipherId => getValue(CIPHER_ID);

  String get compressionFlags => getValue(COMPRESSION_FLAGS);

  String get masterSeed => getValue(MASTER_SEED);

  String get transformSeed => getValue(TRANSFORM_SEED);

  String get encryptionIv => getValue(ENCRYPTION_IV);

  String get kdfParameters => getValue(KDF_PARAMETERS);
}

class Item {
  String _id;
  int _type;
  Uint8List _meta;
  Uint8List _content;
  Uint8List _checksum;

  String get id => _id;

  int get type => _type;

  Uint8List get content => _content;

  Uint8List get meta => _meta;

  Uint8List get checksum => _checksum;
}
