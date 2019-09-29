import 'dart:typed_data';

import 'package:ben_app/crypto/credential.dart';
import 'package:ben_app/crypto/hmac_validator.dart';
import 'package:ben_app/crypto/protected_value.dart';
import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/util/random.dart';
import 'package:encryptions/hex.dart';
import '../format/storage.dart';

class InitializeService {
  final HeaderRepository headerRepository;

  InitializeService(this.headerRepository);

  Future<bool> hasInitialized() async {
    final headers = await headerRepository.getHeaders();
    return headers.isNotEmpty;
  }

  List<Header> initializeHeader(PasswordCredential credential) {
    return [
      Header(Headers.VERSION, "0.1"),
      Header(Headers.CIPHER_ID, Headers.AES),
      Header(Headers.COMPRESSION_FLAGS, Headers.NO_COMPRESSION),
      Header(Headers.MASTER_SEED, Hex.encode(credential.masterSeed)),
      Header(Headers.TRANSFORM_SEED, Hex.encode(credential.masterSeed)),
      Header(Headers.ENCRYPTION_IV, Hex.encode(credential.encryptionIv)),
      Header(Headers.KDF_PARAMETERS, ""),
    ];
  }

  Future<void> initializeDatabase(
      ProtectedValue masterPassword, bool enableFingerPrint) async {
    PasswordCredential credential = PasswordCredential(
        masterPassword,
        RandomStringUtil.generateUUIDasBytes(),
        RandomStringUtil.generateUUIDasBytes(),
        RandomStringUtil.generateUUIDasBytes());
    final List<Header> headers = initializeHeader(credential);
    final HashValidator hashValidator =
        new HmacValidator(await credential.getHashKey());
    final Uint8List checksum =
        hashValidator.computeChecksum(getSourceBytes(headers));
    headers.add(Header(Headers.CHECKSUM, Hex.encode(checksum)));
    await headerRepository.saveHeaders(headers);
  }

  Uint8List getSourceBytes(List<Header> headers) {
    final List<int> bytes = [];
    headers.forEach((header) => bytes.addAll(header.getSources()));
    return Uint8List.fromList(bytes);
  }
}
