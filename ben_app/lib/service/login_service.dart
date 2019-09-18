import 'package:ben_app/crypto/crypto_meta.dart';
import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/storage.dart';

class LoginService {
  final HeaderRepository headerRepository;

  LoginService(this.headerRepository);

  Future<void> validateMasterPassword(String masterPassword) async {
    Header checksum = await headerRepository.getHeader(MetaData.HASH_CHECKSUM);
    assert(checksum != null);


  }
}
