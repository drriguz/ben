import 'dart:convert';

import '../entity/tables.dart';

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

class InitializeService {}
