import 'package:ben_app/crypto/crypto_meta.dart';
import 'package:uuid/uuid.dart';
import 'package:convert/convert.dart';
import '../format/storage.dart';

class InitService {
  final HeaderRepository headerRepository;
  final _uuid = new Uuid();

  InitService(this.headerRepository);

  Future<bool> hasInitialized() async {
    final headers = await headerRepository.getHeaders();
    return headers.isNotEmpty;
  }

  Future<void> initializeDatabase() async {
    MetaData metaData = MetaData(
      version: "0.1",
      cipherId: MetaData.AES,
      compressionFlags: MetaData.NO_COMPRESSION,
      masterSeed: _generateUUID(),
      transformSeed: _generateUUID(),
      encryptionIv: _generateUUID(),
      kdfParameters: "",
      hashChecksum: "",
    );
    await headerRepository.saveHeaders(metaData.headers);
  }

  String _generateUUID() {
    final uuid = new List<int>(16);
    _uuid.v4buffer(uuid);
    return hex.encode(uuid);
  }
}
