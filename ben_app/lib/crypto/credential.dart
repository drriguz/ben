import 'dart:typed_data';

import 'package:ben_app/crypto/protected_value.dart';
import 'package:crypto/crypto.dart';
import 'package:encryptions/encryptions.dart';

abstract class Credential {
  Future<Uint8List> getEncryptionKey();

  Future<Uint8List> getHashKey();
}

class PasswordCredential implements Credential {
  final ProtectedValue _password;
  final Uint8List _masterSeed;
  final Uint8List _encryptionIv;
  final Uint8List _transformSeed;

  PasswordCredential(this._password, this._masterSeed, this._encryptionIv,
      this._transformSeed);

  @override
  Future<Uint8List> getEncryptionKey() {
    final Uint8List plainPasswordHash = sha256.convert(_password.hash).bytes;
    return Encryptions.argon2dRaw(plainPasswordHash, _transformSeed);
  }

  @override
  Future<Uint8List> getHashKey() async {
    final List<int> source = List.from(_masterSeed);
    source.addAll(await getEncryptionKey());
    source.add(0x01);
    return sha512.convert(source).bytes;
  }

  ProtectedValue get password => _password;

  Uint8List get masterSeed => _masterSeed;

  Uint8List get encryptionIv => _encryptionIv;

  Uint8List get transformSeed => _transformSeed;
}
