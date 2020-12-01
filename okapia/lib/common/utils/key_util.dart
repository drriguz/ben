import 'dart:convert';
import 'dart:typed_data';

import 'package:okapia/common/crypto/hmac_validator.dart';
import 'package:okapia/common/crypto/key.dart';
import 'package:okapia/common/crypto/protected_value.dart';

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
    return hashValidator.computeChecksum(utf8.encode(data));
  }
}
