import 'dart:convert';

import 'package:uuid/uuid.dart';
import '../mode/meta_data.dart';
import '../config/version.dart';

/**
 * Data is encrypted by PIN_KEY
 * Secret inside data is encrypted by MASTER_KEY
 *
 * PIN_KEY      = argon2d(2, 1024, sha256(sha256(pin)), pinSeed)
 * MASTER_KEY   = argon2d(2, 1024, sha256(sha256(masterPassword)), masterSeed)
 * HMAC_KEY     = sha512(PIN_KEY + hashSeed)
 * hash         = hmac-sha356(header + ids, HMAC_KEY)
 * CHECKSUM_KEY = sha512(PIN_KEY + id + hashSeed)
 * checksum     = hmac-sha256(data, CHECKSUM_KEY)
 */
enum Cipher {
  AES256_CBC_NOPADDING,
}

class InitializeService {
  final _uuid = new Uuid();

  MetaData createMetaData() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final pinSeed = new List<int>(16);
    final masterSeed = new List<int>(16);
    final hashSeed = new List<int>(16);

    _uuid.v4buffer(pinSeed);
    _uuid.v4buffer(masterSeed);
    _uuid.v4buffer(hashSeed);

    return MetaData(
      version: Version.toString(),
      cipher: Cipher.AES256_CBC_NOPADDING.toString(),
      createTime: now.toString(),
      lastUpdatedTime: now.toString(),
      pinSeed: pinSeed,
      masterSeed: masterSeed,
      hashSeed: hashSeed,
    );
  }
}
