import 'dart:typed_data';

import 'package:ben_app/crypto/protected_value.dart';
import 'package:crypto/crypto.dart';
import 'package:encryptions/encryptions.dart';

import 'kdf.dart';

abstract class Credential {
  Future<Uint8List> getEncryptionKey(final Kdf _kdf);

  Future<Uint8List> getHashKey(final Kdf kdf);
}

class PasswordCredential implements Credential {
  final ProtectedValue _password;
  final Uint8List _masterSeed;
  final Uint8List _encryptionIv;
  final Uint8List _transformSeed;

  PasswordCredential(this._password, this._masterSeed, this._encryptionIv,
      this._transformSeed);

  @override
  Future<Uint8List> getEncryptionKey(final Kdf kdf) async {
    Stopwatch stopwatch = new Stopwatch()..start();
    final Uint8List plainPasswordHash = sha256.convert(_password.hash).bytes;
    Uint8List result = await kdf.derive(plainPasswordHash, _transformSeed);
    print("Password hash generated in ${stopwatch.elapsed} seconds");
    return result;
  }

  @override
  Future<Uint8List> getHashKey(final Kdf kdf) async {
    final List<int> source = List.from(_masterSeed);
    source.addAll(await getEncryptionKey(kdf));
    source.add(0x01);
    return sha512.convert(source).bytes;
  }

  ProtectedValue get password => _password;

  Uint8List get masterSeed => _masterSeed;

  Uint8List get encryptionIv => _encryptionIv;

  Uint8List get transformSeed => _transformSeed;
}
