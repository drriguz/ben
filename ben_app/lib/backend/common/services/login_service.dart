import 'dart:typed_data';
import 'package:convert/convert.dart';

import '../crypto/credential.dart';
import '../crypto/hmac_validator.dart';
import '../crypto/kdf.dart';
import '../crypto/protected_value.dart';
import '../format/data_format.dart';
import '../format/storage.dart';

class PasswordIncorrectError extends Error {}

class LoginService {
  final HeaderRepository _headerRepository;
  final Kdf _kdf;

  LoginService(this._headerRepository, this._kdf);

  Future<PasswordCredential> checkUserCredential(
      ProtectedValue masterPassword) async {
    final List<Header> headers = await _headerRepository.getHeaders();
    final Headers meta = Headers.from(await _headerRepository.getHeaders());
    final PasswordCredential credential = PasswordCredential(
      masterPassword,
      hex.decode(meta.masterSeed),
      hex.decode(meta.encryptionIv),
      hex.decode(meta.transformSeed),
    );
    final HashValidator hashValidator =
        new HmacValidator(await credential.getHashKey(_kdf));
    List<Header> checksumHeaders = List.from(headers);
    checksumHeaders.removeWhere((item) => item.type == Headers.CHECKSUM);

    final String checksum = hex.encode(
        hashValidator.computeChecksum(_getSourceBytes(checksumHeaders)));
    if (checksum == meta.checksum) return credential;
    throw PasswordIncorrectError();
  }

  Uint8List _getSourceBytes(List<Header> headers) {
    final List<int> bytes = [];
    headers.sort((l, r) => l.type.compareTo(r.type));
    headers.forEach((header) => bytes.addAll(header.getSources()));
    return Uint8List.fromList(bytes);
  }
}
