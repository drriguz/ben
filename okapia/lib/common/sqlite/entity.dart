import 'dart:typed_data';

abstract class Entity<ID> {
  ID id;

  Entity(this.id);

  Map<String, dynamic> toJson();
}

abstract class EncryptedData {
  String get id;

  Uint8List get content;
}

abstract class EncryptedMeta {
  String get id;

  Uint8List get meta;
}
