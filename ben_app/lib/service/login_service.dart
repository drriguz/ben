import 'dart:typed_data';

import 'package:ben_app/crypto/credential.dart';
import 'package:ben_app/crypto/hmac_validator.dart';
import 'package:ben_app/crypto/kdf.dart';
import 'package:ben_app/crypto/protected_value.dart';
import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/storage.dart';
import 'package:encryptions/hex.dart';

class PasswordIncorrectError extends Error {}

class LoginService {
  HeaderRepository headerRepository;
  Kdf kdf;

  LoginService();

  Future<PasswordCredential> checkUserCredential(
      ProtectedValue masterPassword) async {
    final List<Header> headers = await headerRepository.getHeaders();
    final Headers meta = Headers.from(await headerRepository.getHeaders());
    final PasswordCredential credential = PasswordCredential(
      masterPassword,
      Hex.decode(meta.masterSeed),
      Hex.decode(meta.encryptionIv),
      Hex.decode(meta.transformSeed),
    );
    final HashValidator hashValidator =
        new HmacValidator(await credential.getHashKey(kdf));
    List<Header> checksumHeaders = List.from(headers);
    checksumHeaders.removeWhere((item) => item.type == Headers.CHECKSUM);

    final String checksum = Hex.encode(
        hashValidator.computeChecksum(getSourceBytes(checksumHeaders)));
    if (checksum == meta.checksum) return credential;
    throw PasswordIncorrectError();
  }

  Uint8List getSourceBytes(List<Header> headers) {
    final List<int> bytes = [];
    headers.sort((l, r) => l.type.compareTo(r.type));
    headers.forEach((header) => bytes.addAll(header.getSources()));
    return Uint8List.fromList(bytes);
  }
}
