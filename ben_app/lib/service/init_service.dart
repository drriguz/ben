import 'package:ben_app/crypto/crypto_meta.dart';
import 'package:ben_app/crypto/protected_value.dart';
import 'package:ben_app/util/random.dart';
import '../format/storage.dart';

class InitializeService {
  final HeaderRepository headerRepository;

  InitializeService(this.headerRepository);

  Future<bool> hasInitialized() async {
    final headers = await headerRepository.getHeaders();
    return headers.isNotEmpty;
  }

  Future<void> initializeDatabase(
      ProtectedValue masterPassword, bool enableFingerPrint) async {
    MetaData metaData = MetaData(
      version: "0.1",
      cipherId: MetaData.AES,
      compressionFlags: MetaData.NO_COMPRESSION,
      masterSeed: RandomStringUtil.generateUUID(),
      transformSeed: RandomStringUtil.generateUUID(),
      encryptionIv: RandomStringUtil.generateUUID(),
      kdfParameters: "32/4/",
      hashChecksum: "",
    );
    await headerRepository.saveHeaders(metaData.headers);
  }
}
