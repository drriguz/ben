import 'dart:convert';

import '../entity/tables.dart';
import '../config/app_injector_config.dart';
import '../mode/meta_data.dart';
import '../config/version.dart';
import 'repository.dart';
import 'package:uuid/uuid.dart';

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
  final AbstractRepository repository =
      InjectorHelper.get<AbstractRepository>();

  void validateDataBase() async {
    List<MetaDataEntity> metaList = await repository.getMetaDatas();
    if (metaList.isEmpty) {
      print("Meta data not exists, start creating...");
      AppMetaData metaData = createMetaData();
      await repository.createMetaData(metaData.toEntities());
    } else {
      AppMetaData metaData = AppMetaData.from(metaList);
    }
  }

  AppMetaData createMetaData() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final pinSeed = new List<int>(16);
    final masterSeed = new List<int>(16);
    final hashSeed = new List<int>(16);

    _uuid.v4buffer(pinSeed);
    _uuid.v4buffer(masterSeed);
    _uuid.v4buffer(hashSeed);

    return AppMetaData(
      version: Version().fullVersion,
      cipher: Cipher.AES256_CBC_NOPADDING.toString(),
      createTime: now.toString(),
      lastUpdatedTime: now.toString(),
      pinSeed: pinSeed,
      masterSeed: masterSeed,
      hashSeed: hashSeed,
      hash: [],
    );
  }
}
