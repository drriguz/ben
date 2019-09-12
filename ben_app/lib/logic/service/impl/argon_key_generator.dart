import 'dart:convert';

import 'package:encryptions/encryptions.dart';
import 'package:crypto/crypto.dart';

import '../key_generator.dart';

class ArgonKeyGenerator implements KeyGenerator {
  @override
  Future<List<int>> transformKey(List<int> plantPassword, List<int> salt) {
    return Encryptions.argon2dRaw(plantPassword, salt);
  }
}
