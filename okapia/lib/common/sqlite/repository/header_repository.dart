import 'package:sqflite/sqflite.dart';

import '../entity/header_entity.dart';
import '../sqlite_repository.dart';

class Headers {
  static const int CHECKSUM = 0;
  static const int VERSION = 1;
  static const int CIPHER_ID = 2;
  static const int COMPRESSION_FLAGS = 3;
  static const int MASTER_SEED = 4;
  static const int TRANSFORM_SEED = 5;
  static const int ENCRYPTION_IV = 6;
  static const int KDF_PARAMETERS = 7;

  static const String AES = "31c1f2e6bf714350be5805216afc5aff";
  static const String NO_COMPRESSION = "No";

  final Map<int, HeaderEntity> _headers;

  Headers.from(List<HeaderEntity> headers) : _headers = Map() {
    headers.forEach((h) => {_headers[h.id] = h});
  }

  String getValue(int type) {
    return _headers[type]?.content;
  }

  String get checksum => getValue(CHECKSUM);

  String get version => getValue(VERSION);

  String get cipherId => getValue(CIPHER_ID);

  String get compressionFlags => getValue(COMPRESSION_FLAGS);

  String get masterSeed => getValue(MASTER_SEED);

  String get transformSeed => getValue(TRANSFORM_SEED);

  String get encryptionIv => getValue(ENCRYPTION_IV);

  String get kdfParameters => getValue(KDF_PARAMETERS);
}

class HeaderRepository extends SqliteRepository<int, HeaderEntity> {
  HeaderRepository(Database db) : super("meta_data", "id", db);

  Future<void> deleteHeader(int type) async {
    return delete(type);
  }

  Future<HeaderEntity> getHeader(int type) async {
    final values = await findById(type);
    return values ?? HeaderEntity.from(values);
  }

  Future<List<HeaderEntity>> getHeaders() async {
    final List<Map<String, dynamic>> results = await db.query(tableName);
    return results.map((values) => HeaderEntity.from(values)).toList();
  }

  Future<void> saveHeaders(List<HeaderEntity> headers) async {
    final batch = db.batch();
    headers.forEach((header) => batch.insert(tableName, header.toJson()));
    await batch.commit();
  }

  Future<void> updateHeader(HeaderEntity header) async {
    return update(header);
  }
}
