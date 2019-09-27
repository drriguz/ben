import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';

class RandomStringUtil {
  static final _random = Random.secure();

  static String generateUUID() {
    return hex.encode(generateUUIDasBytes());
  }

  static List<int> generateUUIDasBytes() {
    return randomBytes(32);
  }

  static Uint8List randomBytes(int length) {
    return Uint8List.fromList(
        List.generate(length, (i) => _random.nextInt(0xff)));
  }
}
