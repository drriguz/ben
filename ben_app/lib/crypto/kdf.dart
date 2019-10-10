import 'dart:typed_data';

import 'package:encryptions/encryptions.dart';

abstract class Kdf {
  Future<Uint8List> derive(Uint8List password, Uint8List salt);
}

class Argon2Kdf implements Kdf {
  @override
  Future<Uint8List> derive(Uint8List password, Uint8List salt) async {
    return Encryptions.argon2dRaw(password, salt);
  }
}
