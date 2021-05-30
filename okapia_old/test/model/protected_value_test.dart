import 'package:okapia/common/crypto/protected_value.dart';
import 'package:test/test.dart';

void main() {
  test('Xor value and salt', () {
    final ProtectedValue p = ProtectedValue.of("hello world");
    expect(p.getText(), "hello world");
    expect(p.binaryValue.lengthInBytes, 11);
  });

  test('equal and hash code', () {
    final ProtectedValue p = ProtectedValue.of("hello world");
    final ProtectedValue p1 = ProtectedValue.of("hello world1");
    final ProtectedValue p2 = ProtectedValue.of("hello world");
    expect(p == p1, false);
    expect(p == p2, true);
    expect(p.hashCode == p1.hashCode, false);
    expect(p.hashCode == p2.hashCode, true);
  });
}
