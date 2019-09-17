import 'dart:convert';
import 'dart:typed_data';

import '../format/data_format.dart';

class MetaData {
  static const int HASH_CHECKSUM = 0;
  static const int VERSION = 1;
  static const int CIPHER_ID = 2;
  static const int COMPRESSION_FLAGS = 3;
  static const int MASTER_SEED = 4;
  static const int TRANSFORM_SEED = 5;
  static const int ENCRYPTION_IV = 6;
  static const int KDF_PARAMETERS = 7;

  static const String AES = "31c1f2e6bf714350be5805216afc5aff";
  static const String NO_COMPRESSION = "No";

  List<Header> headers = [];

  MetaData(
      {String version,
      String cipherId,
      String compressionFlags,
      String masterSeed,
      String transformSeed,
      String encryptionIv,
      String kdfParameters,
      String hashChecksum}) {
    headers.add(Header(HASH_CHECKSUM, hashChecksum));
    headers.add(Header(VERSION, version));
    headers.add(Header(CIPHER_ID, cipherId));
    headers.add(Header(COMPRESSION_FLAGS, compressionFlags));
    headers.add(Header(MASTER_SEED, masterSeed));
    headers.add(Header(TRANSFORM_SEED, transformSeed));
    headers.add(Header(ENCRYPTION_IV, encryptionIv));
    headers.add(Header(KDF_PARAMETERS, kdfParameters));
  }
}
