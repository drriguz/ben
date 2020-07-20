import 'dart:typed_data';

import 'package:okapia/common/crypto/credential.dart';
import 'package:okapia/common/crypto/kdf.dart';
import 'package:encryptions/encryptions.dart';

class Encrypter {
  final PasswordCredential _passwordCredential;
  final Kdf _kdf;

  Encrypter(this._passwordCredential, this._kdf);

  Future<Uint8List> encrypt(Uint8List content) async {
    return _getAES().then((aes) => aes.encrypt(content));
  }

  Future<Uint8List> decrypt(Uint8List content) async {
    return _getAES().then((aes) => aes.decrypt(content));
  }

  Future<AES> _getAES() async {
    return AES.ofCBC(
      await _passwordCredential.getEncryptionKey(_kdf),
      _passwordCredential.encryptionIv,
      PaddingScheme.PKCS5Padding,
    );
  }
}
