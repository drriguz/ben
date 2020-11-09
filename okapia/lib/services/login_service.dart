import 'dart:convert';
import 'dart:typed_data';
import 'package:okapia/common/crypto/credential.dart';
import 'package:okapia/common/crypto/hmac_validator.dart';
import 'package:okapia/common/crypto/kdf.dart';
import 'package:okapia/common/crypto/key.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/common/sqlite/entity/header_entity.dart';
import 'package:okapia/common/sqlite/repository/header_repository.dart';
import 'package:convert/convert.dart';
import 'package:okapia/common/utils/random.dart';

import 'config_service.dart';

class PasswordIncorrectError extends Error {}

class LoginService {
  final ConfigService _configService;

  LoginService(this._configService);

  Future<Key> checkUserCredential(ProtectedValue masterPassword) async {
    final config = await _configService.readConfig();
    _configService.verifyConfig(config.appConfig);
    final Key key = await Key.create(
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

    print("\na: ${hex.encode(checksum)} \nc: ${config.signature}");
    if (hex.encode(checksum) == config.signature) return key;
    throw PasswordIncorrectError();
  }
}
