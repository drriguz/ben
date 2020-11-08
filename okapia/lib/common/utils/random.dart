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
}
