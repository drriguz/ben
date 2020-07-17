import 'dart:typed_data';

import '../entity.dart';

class MetaView implements EncryptedMeta {
  final String id;
  final Uint8List meta;

  MetaView(this.id, this.meta);

  static MetaView from(Map<String, dynamic> values) => MetaView(
        values["id"],
        values["meta"],
      );
}
