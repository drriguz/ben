import 'dart:convert';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:flutter/services.dart';
import 'package:native_sqlcipher/native_sqlcipher.dart';

import 'config_service.dart';
import '../common/crypto/key.dart';
import '../common/utils/key_util.dart';
import '../common/utils/random.dart';
import '../common/crypto/protected_value.dart';

class InitializeService {
  final ConfigService _configService;

  InitializeService(this._configService);

  Future<void> initialize(
    final ProtectedValue masterPassword,
    final ProtectedValue secondaryPassword,
    bool enableFingerPrint,
  ) async {
    final config =
        await _configService.createConfig(masterPassword, enableFingerPrint);
    final TransformedKey key = await TransformedKey.create(
      config.clientId,
      masterPassword,
      IDUtil.parseUUID(config.masterSeed),
      IDUtil.parseUUID(config.transformSeed),
      IDUtil.parseUUID(config.encryptionIV),
    );
    final TransformedKey secondaryKey = await TransformedKey.create(
      config.clientId,
      secondaryPassword,
      IDUtil.parseUUID(config.secondarySeed),
      IDUtil.parseUUID(config.transformSeed),
      IDUtil.parseUUID(config.encryptionIV),
    );
    final String configData = jsonEncode(config);

    final signature1 =
        await KeyUtil.computeChecksum(key, config.clientId, configData);
    final signature2 = await KeyUtil.computeChecksum(
        secondaryKey, config.clientId, configData);
    final File databaseFile =
        await ConfigService.localFile("${config.clientId}.dat");
    await _initializeDatabase(
        databaseFile.path, await KeyUtil.getSqlcipherKey(key));

    await _saveConfig(
        configData, hex.encode(signature1), hex.encode(signature2));
  }

  Future<void> _saveConfig(
    final String configData,
    final String masterHash,
    final String secondaryHash,
  ) async {
    final File file = await ConfigService.configFile();
    print("saving config to: ${file.path}");
    List<String> lines = [configData, masterHash, secondaryHash];
    await file.writeAsString(lines.join("\n"));
  }

  Future<void> _initializeDatabase(
      final String dbPath, final ProtectedValue sqlcipherKey) async {
    /**
     * Do not include sqflite plugin, otherwise it will conflict with sqlcipher
     * the key will not be correct.
     */
    Database db =
        new Database(dbPath, "x'${hex.encode(sqlcipherKey.binaryValue)}'");
    final String script = await rootBundle.loadString("assets/db/init.sql");
    db.execute("BEGIN;");
    for (String line in script.split(";")) {
      final String sql = line.trim();
      if (sql.isNotEmpty) {
        print("Executing:" + sql);
        db.execute(sql);
      }
    }
    db.execute("COMMIT;");
    db.close();
  }
}
