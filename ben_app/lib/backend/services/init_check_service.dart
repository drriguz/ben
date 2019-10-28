import 'dart:typed_data';

import 'package:ben_app/crypto/credential.dart';
import 'package:ben_app/crypto/hmac_validator.dart';
import 'package:ben_app/crypto/protected_value.dart';
import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/util/random.dart';
import 'package:encryptions/hex.dart';
import '../../format/storage.dart';

class InitializeCheckService {
  final HeaderRepository headerRepository;

  InitializeCheckService(this.headerRepository);

  Future<bool> hasInitialized() async {
    final headers = await headerRepository.getHeaders();
    return headers.isNotEmpty;
  }
}
