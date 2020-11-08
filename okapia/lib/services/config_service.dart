import 'dart:convert';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:okapia/common/crypto/credential.dart';
import 'package:okapia/common/crypto/kdf.dart';
import 'package:okapia/common/crypto/key.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/common/utils/path_util.dart';
import 'package:okapia/common/utils/random.dart';

class AppConfig {
  final String version;
  final String clientId;
  final String cipherType;
  final String compressionFlags;
  final String masterSeed;
  final String transformSeed;
  final String encryptionIV;
  final String kdfParameters;
  final String device;

  AppConfig(
      {this.version,
      this.clientId,
      this.cipherType,
      this.compressionFlags,
      this.masterSeed,
      this.transformSeed,
      this.encryptionIV,
      this.kdfParameters,
      this.device});

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      version: json["version"],
      clientId: json["clientId"],
      cipherType: json["cipherType"],
      compressionFlags: json["compressionFlags"],
      masterSeed: json["masterSeed"],
      transformSeed: json["transformSeed"],
      encryptionIV: json["encryptionIV"],
      kdfParameters: json["kdfParameters"],
      device: json["device"],
    );
  }

  Map<String, dynamic> toJson() => {
        'version': version,
        'clientId': clientId, // sqlite3 file name = ${clientId}.dat
        'cipherType': cipherType, // AES-256
        'compressionFlags': compressionFlags,
        'masterSeed': masterSeed,
        'transformSeed': transformSeed,
        'encryptionIV': encryptionIV,
        'kdfParameters': kdfParameters,
        'device': device,
      };
}

class ConfigService {
  static const String CONFIG_FILE = "config.dat";
  static const String VERSION = "Okapia_1.0";
  static const String AES_256_CBC = "AES/256/CBC";
  static const String NO_COMPRESSION = "no";

  Future<bool> hasInitialized() async {
    final File config = await configFile();
    return config.existsSync();
  }

  Future<AppConfig> readConfig(final ProtectedValue masterPassword) async {
    final File config = await configFile();

    final lines = await config.readAsLines();
    assert(lines.length == 3);
    final String signature = lines[0];
    final String hmacChecksum = lines[1];
    final String configData = lines[2];

    // return new PublicConfig(version, indexDb, signature);
    //
    // List<String> lines = [config.version, config.indexDb, config.signature];
    // return file.writeAsString(lines.join("\n"));
  }

//  Future<AppConfig> createConfig(final ProtectedValue masterPassword) async {
//    final config = await _createConfig(masterPassword);
//    final configJson = jsonEncode(config);
//
//    print(configJson);
//    final File file = await configFile();
//  }

  Future<AppConfig> createConfig(final ProtectedValue masterPassword) async {
    final masterSeed = IDUtil.generateUUID();
    final transformSeed = IDUtil.generateUUID();
    final encryptionIV = IDUtil.generateUUID();
    return AppConfig(
      version: VERSION,
      clientId: IDUtil.generateUUID(),
      cipherType: AES_256_CBC,
      compressionFlags: NO_COMPRESSION,
      masterSeed: masterSeed,
      transformSeed: transformSeed,
      encryptionIV: encryptionIV,
      kdfParameters: 'default',
      device: '',
    );
  }

  static Future<File> configFile() async {
    return new File(await PathUtil.getLocalPath(CONFIG_FILE));
  }

  static Future<bool> isConfigExists() async {
    final config = await configFile();
    return config.exists();
  }
}
