import 'dart:typed_data';
import 'package:crypto/crypto.dart';

abstract class Hashable {
  Uint8List getSources();
}

abstract class HashValidator {
  Uint8List computeChecksum(final Uint8List bytes);
}

class HmacValidator implements HashValidator {
  final Uint8List key;
  final Hmac hmac;

  HmacValidator(this.key) : hmac = new Hmac(sha256, key);

  @override
  Uint8List computeChecksum(Uint8List bytes) {
    assert(bytes != null);
    return hmac.convert(bytes).bytes;
  }
}
