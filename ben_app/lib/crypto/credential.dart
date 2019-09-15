import 'dart:typed_data';

import 'package:ben_app/crypto/protected_value.dart';
import 'package:crypto/crypto.dart';

abstract class Credential {
  Uint8List getKey();
}

class PasswordCredential implements Credential {
  final ProtectedValue _password;

  PasswordCredential(this._password);

  @override
  Uint8List getKey() {
    assert(_password != null);
    return sha256.convert(_password.hash).bytes as Uint8List;
  }
}
