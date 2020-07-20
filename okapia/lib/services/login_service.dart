import 'dart:typed_data';
import 'package:okapia/common/crypto/credential.dart';
import 'package:okapia/common/crypto/hmac_validator.dart';
import 'package:okapia/common/crypto/kdf.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/common/sqlite/entity/header_entity.dart';
import 'package:okapia/common/sqlite/repository/header_repository.dart';
import 'package:convert/convert.dart';

class PasswordIncorrectError extends Error {}

class LoginService {
  final HeaderRepository _headerRepository;
  final Kdf _kdf;

  LoginService(this._headerRepository, this._kdf);

  Future<PasswordCredential> checkUserCredential(
      ProtectedValue masterPassword) async {
    final List<HeaderEntity> headers = await _headerRepository.getHeaders();
    final Headers meta = Headers.from(headers);
    final PasswordCredential credential = PasswordCredential(
      masterPassword,
      hex.decode(meta.masterSeed),
      hex.decode(meta.encryptionIv),
      hex.decode(meta.transformSeed),
    );
    final HashValidator hashValidator =
        new HmacValidator(await credential.getHashKey(_kdf));
    List<HeaderEntity> checksumHeaders = List.from(headers);
    checksumHeaders.removeWhere((item) => item.id == Headers.CHECKSUM);

    final String checksum = hex.encode(
        hashValidator.computeChecksum(_getSourceBytes(checksumHeaders)));
    if (checksum == meta.checksum) return credential;
    throw PasswordIncorrectError();
  }

  Uint8List _getSourceBytes(List<HeaderEntity> headers) {
    final List<int> bytes = [];
    headers.sort((l, r) => l.id.compareTo(r.id));
    headers.forEach((header) => bytes.addAll(header.getSources()));
    return Uint8List.fromList(bytes);
  }
}
