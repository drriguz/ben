import 'dart:convert';
import 'dart:typed_data';

import '../crypto/hmac_validator.dart';
import '../crypto/key.dart';
import '../crypto/protected_value.dart';

import 'random.dart';

class KeyUtil {
  static Future<ProtectedValue> getSqlcipherKey(TransformedKey key) async {
    final encryptionKey = await key.getEncryptionKey();
    final sqlcipherKey = List<int>.from(encryptionKey.binaryValue)
      ..addAll(key.encryptionIV);
    return ProtectedValue.ofBinary(Uint8List.fromList(sqlcipherKey));
  }

  static Future<Uint8List> computeChecksum(
      TransformedKey key, String itemId, String data) async {
    final configHmacKey = await key.getHmacKey(IDUtil.parseUUID(itemId));
    final HmacValidator hashValidator =
        new HmacValidator(configHmacKey.binaryValue);
    return hashValidator.computeChecksum(Uint8List.fromList(utf8.encode(data)));
  }
}
