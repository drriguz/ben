import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:okapia/common/crypto/kdf.dart';

import 'protected_value.dart';

/// sqlcipher encryption:
/// use raw key without derivation, ref: https://www.zetetic.net/sqlcipher/sqlcipher-api/#rekey
///
/// PRAGMA key = "x'98483C6EB40B6C31A448C22A66DED3B5E5E8D5119CAC8327B655C8B5C483648101010101010101010101010101010101'";
/// db_key(32bytes) + db_salt(16bytes)
///
/// master_password(plain)
/// transformedMasterKey = argon2d(2, 1024, sha256(sha256(plain_password)), transformSeed)
/// encryptionKey = sha256(masterSeed + transformedMasterKey)
/// encrypted = aes256(encryptionKey, encryptionIV, raw)
/// hmacKey = sha512(itemId + sha512(masterSeed + transformedMasterKey))
/// checksum = hmac-sha256(hmacKey, raw)
///
/// for sqlcipher, it's AES-256 CBC
/// for external files, also AES-256 CBC
/// and use the same key/salt
///

class Key {
  static final Kdf _kdf = new Argon2Kdf();

  final ProtectedValue _transformedMasterKey;
  final Uint8List _masterSeed;
  final Uint8List encryptionIV;

  ProtectedValue _encryptionKeyCache;
  ProtectedValue _hmacKeyCache;

  Key._internal(
      this._transformedMasterKey, this._masterSeed, this.encryptionIV) {}

  static Future<Key> create(
      final ProtectedValue masterPassword,
      final Uint8List masterSeed,
      final Uint8List transformSeed,
      final Uint8List encryptionIV) async {
    assert(transformSeed.length == 16);
    assert(masterSeed.length == 16);
    assert(encryptionIV.length == 16);

    // transformedMasterKey = argon2d(2, 1024, sha256(sha256(plain_password)), transformSeed)
    final Uint8List passwordHash =
        sha256.convert(sha256.convert(masterPassword.binaryValue).bytes).bytes;
    final Uint8List transformedMasterKey =
        await _kdf.derive(passwordHash, transformSeed);

    return new Key._internal(ProtectedValue.ofBinary(transformedMasterKey),
        masterSeed, encryptionIV);
  }

  Future<ProtectedValue> getEncryptionKey() async {
    // encryptionKey = sha256(masterSeed + transformedMasterKey)
    if (_encryptionKeyCache == null) {
      final List<int> source = List.from(_masterSeed)
        ..addAll(_transformedMasterKey.binaryValue);
      final key = sha256.convert(source).bytes;
      _encryptionKeyCache = ProtectedValue.ofBinary(key);
    }
    return _encryptionKeyCache;
  }

  Future<ProtectedValue> getHmacKey(final Uint8List itemId) async {
    assert(itemId.length == 16); // should be an uuid

    // hmacKey = sha512(itemId + sha512(masterSeed + transformedMasterKey))
    final temp = sha512
        .convert(
            List.from(_masterSeed)..addAll(_transformedMasterKey.binaryValue))
        .bytes;
    final key = sha512.convert(List.from(itemId)..addAll(temp)).bytes;
    return ProtectedValue.ofBinary(key);
  }
}
