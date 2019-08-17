import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../mode/meta_data.dart';
import '../hash_validator.dart';

class HmacValidator implements HashValidator {
  final List<int> hashKey;
  final Hmac hmac256;

  HmacValidator(this.hashKey) : hmac256 = new Hmac(sha256, hashKey);

  @override
  List<int> computeChecksum(AppMetaData meta, List<String> dataIds) {
    assert(meta != null && dataIds != null);
    final header = meta.toEntities(withHash: false);
    header.sort((l, r) => l.name.compareTo(r.name));
    dataIds.sort();
    final List<int> bytes = utf8.encode(jsonEncode({
      "header": header,
      "data": dataIds,
    }));

    return hmac256.convert(bytes).bytes;
  }
}
