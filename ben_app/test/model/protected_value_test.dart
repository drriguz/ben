import 'package:ben_app/logic/model/protected_value.dart';
import 'package:test/test.dart';

void main() {
  test('Xor value and salt', () {
    final ProtectedValue p = ProtectedValue.of("hello world");
    expect(p.getText(), "hello world");
    expect(p.binaryValue.lengthInBytes, 11);
  });
}
