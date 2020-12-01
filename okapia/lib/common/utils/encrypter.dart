import 'dart:typed_data';

import 'package:encryptions/encryptions.dart';
import 'package:okapia/common/crypto/key.dart';

class Encrypter {
  final TransformedKey _key;

  Encrypter(this._key);

  Future<Uint8List> encrypt(Uint8List content) async {
    return _getAES().then((aes) => aes.encrypt(content));
  }

  Future<Uint8List> decrypt(Uint8List content) async {
    return _getAES().then((aes) => aes.decrypt(content));
  }

  Future<AES> _getAES() async {
    return AES.ofCBC(
      (await _key.getEncryptionKey()).binaryValue,
      _key.encryptionIV,
      PaddingScheme.PKCS5Padding,
    );
  }
}
