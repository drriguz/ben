import 'dart:convert';
import 'dart:io';

import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/common/utils/path_util.dart';
import 'package:okapia/common/utils/random.dart';
import 'package:okapia/exception/config.dart';

class AppConfig {
  final String version;
  final String clientId;
  final String cipherType;
  final String compressionFlags;
  final String masterSeed;
  final String secondarySeed;
  final String transformSeed;
  final String encryptionIV;
  final String kdfParameters;
  final String device;
  final bool localAuth;

  AppConfig(
      {this.version,
      this.clientId,
      this.cipherType,
      this.compressionFlags,
      this.masterSeed,
      this.secondarySeed,
      this.transformSeed,
      this.encryptionIV,
      this.kdfParameters,
      this.device,
      this.localAuth});

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      version: json["version"],
      clientId: json["clientId"],
      cipherType: json["cipherType"],
      compressionFlags: json["compressionFlags"],
      masterSeed: json["masterSeed"],
      secondarySeed: json["secondarySeed"],
      transformSeed: json["transformSeed"],
      encryptionIV: json["encryptionIV"],
      kdfParameters: json["kdfParameters"],
      device: json["device"],
      localAuth: json["localAuth"],
    );
  }

  Map<String, dynamic> toJson() => {
        'version': version,
        'clientId': clientId, // sqlite3 file name = ${clientId}.dat
        'cipherType': cipherType, // AES-256
        'compressionFlags': compressionFlags,
        'masterSeed': masterSeed,
        'secondarySeed': secondarySeed,
        'transformSeed': transformSeed,
        'encryptionIV': encryptionIV,
        'kdfParameters': kdfParameters,
        'device': device,
        'localAuth': localAuth,
      };
}

class AppConfigWithSignature {
  final AppConfig appConfig;
  final String signature;
  final String secondarySignature;

  AppConfigWithSignature(
      this.appConfig, this.signature, this.secondarySignature);
}

class ConfigService {
  static const String CONFIG_FILE = "app.config";
  static const String VERSION = "Okapia_1.0";
  static const String AES_256_CBC = "AES/256/CBC";
  static const String NO_COMPRESSION = "no";

  Future<bool> hasInitialized() async {
    final File config = await configFile();
    return config.existsSync();
  }

  Future<AppConfigWithSignature> readConfig() async {
    final File config = await configFile();
    print("config: ${config.path}");

    final lines = await config.readAsLines();
    if (lines.length != 3)
      throw new InvalidConfigFormatException("Invalid config file");
    final String configData = lines[0];
    final String signature = lines[1];
    final String secondarySignature = lines[2];

    if (signature.length != 64 || secondarySignature.length != 64) // 32bit hex
      throw new InvalidConfigFormatException("Invalid config signature");

    final appConfig = AppConfig.fromJson(jsonDecode(configData));
    return new AppConfigWithSignature(appConfig, signature, secondarySignature);
  }

  Future<void> verifyConfig(final AppConfig config) async {
    if (config.version != VERSION)
      throw new InvalidConfigDataException("Unsupported version");
    final dbFile = await ConfigService.localFile("${config.clientId}.dat");
    if (!dbFile.existsSync())
      throw new InvalidConfigDataException("Database file not exists");
    if (config.cipherType != AES_256_CBC)
      throw new InvalidConfigDataException("Unsupported encryption mechanism");
    if (!IDUtil.isUUIDFormat(config.encryptionIV))
      throw new InvalidConfigDataException(
          "Invalid IV: ${config.encryptionIV}");
    if (!IDUtil.isUUIDFormat(config.masterSeed))
      throw new InvalidConfigDataException(
          "Invalid master seed: ${config.masterSeed}");
    if (!IDUtil.isUUIDFormat(config.secondarySeed))
      throw new InvalidConfigDataException(
          "Invalid secondary seed: ${config.secondarySeed}");
    if (!IDUtil.isUUIDFormat(config.transformSeed))
      throw new InvalidConfigDataException(
          "Invalid transform seed: ${config.transformSeed}");
  }

  Future<AppConfig> createConfig(
      final ProtectedValue masterPassword, bool enableLocalAuth) async {
    final masterSeed = IDUtil.generateUUID();
    final secondarySeed = IDUtil.generateUUID();
    final transformSeed = IDUtil.generateUUID();
    final encryptionIV = IDUtil.generateUUID();
    return AppConfig(
      version: VERSION,
      clientId: IDUtil.generateUUID(),
      cipherType: AES_256_CBC,
      compressionFlags: NO_COMPRESSION,
      masterSeed: masterSeed,
      secondarySeed: secondarySeed,
      transformSeed: transformSeed,
      encryptionIV: encryptionIV,
      kdfParameters: 'default',
      device: '',
      localAuth: enableLocalAuth,
    );
  }

  static Future<File> configFile() async {
    return new File(await PathUtil.getLocalPath(CONFIG_FILE));
  }

  static Future<File> localFile(String path) async {
    return new File(await PathUtil.getLocalPath(path));
  }

  static Future<bool> isConfigExists() async {
    final config = await configFile();
    return config.exists();
  }
}
