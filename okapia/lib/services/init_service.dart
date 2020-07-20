import 'dart:typed_data';
import 'package:okapia/common/sqlite/entity/header_entity.dart';
import 'package:convert/convert.dart';

import '../common/sqlite/repository/header_repository.dart';
import '../common/crypto/credential.dart';
import '../common/crypto/hmac_validator.dart';
import '../common/crypto/kdf.dart';
import '../common/crypto/protected_value.dart';
import '../common/utils/random.dart';

class InitializeService {
  final HeaderRepository _headerRepository;
  final Kdf _kdf;

  InitializeService(this._headerRepository, this._kdf);

  Future<void> initialize(
      ProtectedValue masterPassword, bool enableFingerPrint) async {
    PasswordCredential credential = PasswordCredential(
        masterPassword,
        RandomStringUtil.generateUUIDasBytes(),
        RandomStringUtil.generateUUIDasBytes(),
        RandomStringUtil.generateUUIDasBytes());
    final List<HeaderEntity> headers = _createHeaderWithoutChecksum(credential);
    final HashValidator hashValidator =
        new HmacValidator(await credential.getHashKey(_kdf));
    final Uint8List checksum =
        hashValidator.computeChecksum(_getSourceBytes(headers));
    headers
        .add(HeaderEntity(id: Headers.CHECKSUM, content: hex.encode(checksum)));
    await _headerRepository.saveHeaders(headers);
  }

  List<HeaderEntity> _createHeaderWithoutChecksum(
      PasswordCredential credential) {
    return [
      HeaderEntity(id: Headers.VERSION, content: "0.1"),
      HeaderEntity(id: Headers.CIPHER_ID, content: Headers.AES),
      HeaderEntity(
          id: Headers.COMPRESSION_FLAGS, content: Headers.NO_COMPRESSION),
      HeaderEntity(
          id: Headers.MASTER_SEED, content: hex.encode(credential.masterSeed)),
      HeaderEntity(
          id: Headers.TRANSFORM_SEED,
          content: hex.encode(credential.transformSeed)),
      HeaderEntity(
          id: Headers.ENCRYPTION_IV,
          content: hex.encode(credential.encryptionIv)),
      HeaderEntity(id: Headers.KDF_PARAMETERS, content: ""),
    ];
  }

  Uint8List _getSourceBytes(List<HeaderEntity> headers) {
    final List<int> bytes = [];
    headers.sort((l, r) => l.id.compareTo(r.id));
    headers.forEach((header) => bytes.addAll(header.getSources()));
    return Uint8List.fromList(bytes);
  }
}
