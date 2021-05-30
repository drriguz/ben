import 'dart:convert';
import 'dart:io';
import 'package:native_sqlcipher/native_sqlcipher.dart';
import 'package:okapia/common/crypto/hmac_validator.dart';
import 'package:okapia/common/crypto/key.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:convert/convert.dart';
import 'package:okapia/common/utils/key_util.dart';
import 'package:okapia/common/utils/random.dart';

import 'config_service.dart';

class PasswordIncorrectError extends Error {}

class LoginService {
  final ConfigService _configService;

  LoginService(this._configService);

  Future<Database> openSqlcipher(final TransformedKey key) async {
    final File databaseFile =
        await ConfigService.localFile("${key.clientId}.dat");
    final dbKey = await KeyUtil.getSqlcipherKey(key);
    final db =
        new Database(databaseFile.path, "x'${hex.encode(dbKey.binaryValue)}'");
    //fixme: only for debugging
    print(
        "opening db: ${databaseFile.path}\n pragma key=\"x'${hex.encode(dbKey.binaryValue)}'\"");

    db.execute("SELECT count(*) FROM sqlite_master;");
    return db;
  }

  Future<TransformedKey> checkUserCredential(ProtectedValue masterPassword) async {
    return _checkPassword(masterPassword, false);
  }

  Future<TransformedKey> checkSecondaryPassword(ProtectedValue secondaryPassword) async {
    return _checkPassword(secondaryPassword, true);
  }

  Future<TransformedKey> _checkPassword(
      ProtectedValue password, bool isSecondaryPassword) async {
    final config = await _configService.readConfig();
    _configService.verifyConfig(config.appConfig);
    final TransformedKey key = await TransformedKey.create(
      config.appConfig.clientId,
      password,
      IDUtil.parseUUID(isSecondaryPassword
          ? config.appConfig.secondarySeed
          : config.appConfig.masterSeed),
      IDUtil.parseUUID(config.appConfig.transformSeed),
      IDUtil.parseUUID(config.appConfig.encryptionIV),
    );

    final String configData = jsonEncode(config.appConfig);
    final signature = await KeyUtil.computeChecksum(
        key, config.appConfig.clientId, configData);

    String expectedSignature =
        isSecondaryPassword ? config.secondarySignature : config.signature;
    if (hex.encode(signature) == expectedSignature) return key;
    throw PasswordIncorrectError();
  }
}
