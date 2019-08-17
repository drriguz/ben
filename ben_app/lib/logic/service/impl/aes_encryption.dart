import 'dart:typed_data';
import 'package:encryptions/encryptions.dart';

import '../encryption.dart';

class AesEncryption implements Encryption {
  final Uint8List key;
  final Uint8List iv;

  AesEncryption(List<int> key, List<int> iv)
      : key = Uint8List.fromList(key),
        iv = Uint8List.fromList(iv);

  @override
  Future<List<int>> decrypt(List<int> raw) async {
    final Uint8List decrypted = await Encryptions.aesDecrypt(key, iv, raw);
    return decrypted.toList();
  }

  @override
  Future<List<int>> encrypt(List<int> raw) async {
    final Uint8List encrypted = await Encryptions.aesEncrypt(key, iv, raw);
    return encrypted.toList();
  }
}
