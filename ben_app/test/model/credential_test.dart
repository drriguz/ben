import 'package:ben_app/crypto/credential.dart';
import 'package:ben_app/crypto/protected_value.dart';
import 'package:test/test.dart';
import 'package:convert/convert.dart';

void main() {
  test('Xor value and salt', () {
    ProtectedValue password = ProtectedValue.of("1125482715");
    Credential credential = PasswordCredential(password);
    expect(hex.encode(credential.getKey()),
        "bfa11b4e4376cf1b17088a3de375f1df6a9c4cb3eb36f3ce2416b10481eb619f");
  });
}
