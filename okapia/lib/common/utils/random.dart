import 'dart:typed_data';

import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class IDUtil {
  static final _uuid = new Uuid(options: {'grng': UuidUtil.cryptoRNG});

  static String generateUUID() {
    return _uuid.v4();
  }

  static Uint8List generateUUIDasBytes() {
    final List<int> buffer = new List<int>(32);
    return Uint8List.fromList(_uuid.v4buffer(buffer));
  }

  static Uint8List parseUUID(final String uuid) {
    return Uint8List.fromList(_uuid.parse(uuid));
  }

  static final RegExp UUID_REGEX = new RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
      caseSensitive: false);

  static bool isUUIDFormat(final String t) {
    return UUID_REGEX.hasMatch(t);
  }
}
