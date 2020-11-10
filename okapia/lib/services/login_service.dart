import 'dart:convert';
import 'dart:io';
import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/crypto/hmac_validator.dart';
import 'package:okapia/common/crypto/key.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:convert/convert.dart';
import 'package:okapia/common/utils/random.dart';

import 'config_service.dart';

class PasswordIncorrectError extends Error {}

class LoginService {
  final ConfigService _configService;

  LoginService(this._configService);

  Future<Database> openSqlcipher(final Key key) async {
    final File databaseFile =
        await ConfigService.localFile("${key.clientId}.dat");
    final dbKey = await key.getSqlcipherKey();
    final db =
        new Database(databaseFile.path, "x'${hex.encode(dbKey.binaryValue)}'");
    //fixme: only for debugging
    print("opening db: ${databaseFile.path}\n pragma key=\"x'${hex.encode(dbKey.binaryValue)}'\"");

    db.execute("SELECT count(*) FROM sqlite_master;");
    return db;
  }

  Future<Key> checkUserCredential(ProtectedValue masterPassword) async {
    final config = await _configService.readConfig();
    _configService.verifyConfig(config.appConfig);
    final Key key = await Key.create(
      config.appConfig.clientId,
      masterPassword,
      IDUtil.parseUUID(config.appConfig.masterSeed),
      IDUtil.parseUUID(config.appConfig.transformSeed),
      IDUtil.parseUUID(config.appConfig.encryptionIV),
    );

    final String configData = jsonEncode(config.appConfig);
    final configHmacKey =
        await key.getHmacKey(IDUtil.parseUUID(config.appConfig.clientId));
    final HmacValidator hashValidator =
        new HmacValidator(configHmacKey.binaryValue);
    final checksum = hashValidator.computeChecksum(utf8.encode(configData));

    if (hex.encode(checksum) == config.signature) return key;
    throw PasswordIncorrectError();
  }
}
