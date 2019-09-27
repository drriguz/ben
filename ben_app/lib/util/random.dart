import 'package:uuid/uuid.dart';
import 'package:convert/convert.dart';

class RandomStringUtil {
  static final _uuid = new Uuid();

  static String generateUUID() {
    return hex.encode(generateUUIDasBytes());
  }

  static List<int> generateUUIDasBytes() {
    final uuid = new List<int>(16);
    _uuid.v4buffer(uuid);
    return uuid;
  }
}
