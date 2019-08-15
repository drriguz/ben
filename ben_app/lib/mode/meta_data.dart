import 'dart:convert';

import '../entity/tables.dart';

class AppMetaData {
  final String version;
  final String cipher;
  final String createTime;
  final String lastUpdatedTime;
  final List<int> pinSeed;
  final List<int> masterSeed;
  final List<int> hashSeed;
  final List<int> hash;

  const AppMetaData(
      {this.version,
      this.cipher,
      this.createTime,
      this.lastUpdatedTime,
      this.pinSeed,
      this.masterSeed,
      this.hashSeed,
      this.hash});

  static AppMetaData from(List<MetaDataEntity> list) {
    final Map<String, List<int>> values = {};
    list.forEach((e) {
      values[e.name] = e.value;
    });
    return AppMetaData(
        version: _getStringValue(values["version"]),
        cipher: _getStringValue(values["cipher"]),
        createTime: _getStringValue(values["createTime"]),
        lastUpdatedTime: _getStringValue(values["lastUpdatedTime"]),
        pinSeed: values["pinSeed"],
        masterSeed: values["masterSeed"],
        hashSeed: values["hashSeed"],
        hash: values["hash"]);
  }

  List<MetaDataEntity> toEntities() {
    return <MetaDataEntity>[
      MetaDataEntity("version", utf8.encode(version)),
      MetaDataEntity("cipher", utf8.encode(cipher)),
      MetaDataEntity("createTime", utf8.encode(createTime)),
      MetaDataEntity("lastUpdatedTime", utf8.encode(lastUpdatedTime)),
      MetaDataEntity("pinSeed", pinSeed),
      MetaDataEntity("masterSeed", masterSeed),
      MetaDataEntity("hashSeed", hashSeed),
      MetaDataEntity("hash", hash),
    ];
  }

  static String _getStringValue(final List<int> bytes) {
    assert(bytes != null, "String bytes should not be null");
    return utf8.decode(bytes);
  }
}
