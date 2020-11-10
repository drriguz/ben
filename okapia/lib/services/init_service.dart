import 'dart:convert';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:flutter/services.dart';
import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/crypto/hmac_validator.dart';
import 'package:okapia/common/crypto/key.dart';
import 'package:okapia/common/utils/random.dart';
import 'package:okapia/services/config_service.dart';

import '../common/crypto/protected_value.dart';

class InitializeService {
  final ConfigService _configService;

  InitializeService(this._configService);

  Future<void> initialize(
      final ProtectedValue masterPassword, bool enableFingerPrint) async {
    final config =
        await _configService.createConfig(masterPassword, enableFingerPrint);
    final Key key = await Key.create(
      config.clientId,
      masterPassword,
      IDUtil.parseUUID(config.masterSeed),
      IDUtil.parseUUID(config.transformSeed),
      IDUtil.parseUUID(config.encryptionIV),
    );
    final String configData = jsonEncode(config);
    final configHmacKey =
        await key.getHmacKey(IDUtil.parseUUID(config.clientId));
    final HmacValidator hashValidator =
        new HmacValidator(configHmacKey.binaryValue);
    final checksum = hashValidator.computeChecksum(utf8.encode(configData));

    final File databaseFile =
        await ConfigService.localFile("${config.clientId}.dat");
    await _initializeDatabase(databaseFile.path, await key.getSqlcipherKey());

    await _saveConfig(configData, hex.encode(checksum));
  }

  Future<void> _saveConfig(final String configData, final String hash) async {
    final File file = await ConfigService.configFile();
    print("saving config to: ${file.path}");
    List<String> lines = [configData, hash];
    await file.writeAsString(lines.join("\n"));
  }

  Future<void> _initializeDatabase(
      final String dbPath, final ProtectedValue sqlcipherKey) async {
    Database db =
        new Database(dbPath, "x'${hex.encode(sqlcipherKey.binaryValue)}'");
    final String script =
        await rootBundle.loadString("assets/config/create_db.sql");
    db.execute(script);
    db.close();
  }
}
