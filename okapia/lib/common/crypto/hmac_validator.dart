import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class HmacValidator {
  final Uint8List key;
  final Hmac hmac;

  HmacValidator(this.key) : hmac = new Hmac(sha256, key);

  Uint8List computeChecksum(Uint8List bytes) {
    assert(bytes != null);
    return Uint8List.fromList(hmac.convert(bytes).bytes);
  }
}
