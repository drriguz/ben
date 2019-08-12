import 'dart:convert';
import "dart:typed_data";

abstract class Encryption {
  List<int> encrypt(final List<int> raw);

  List<int> decrypt(final List<int> raw);
}
