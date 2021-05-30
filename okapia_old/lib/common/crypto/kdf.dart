import 'dart:typed_data';

import 'package:encryptions/encryptions.dart';

abstract class Kdf {
  Future<Uint8List> derive(Uint8List password, Uint8List salt);
}

class Argon2Kdf implements Kdf {
  @override
  Future<Uint8List> derive(Uint8List password, Uint8List salt) async {
    Argon2 argon2 = new Argon2();
    return argon2.argon2i(password, salt);
  }
}
