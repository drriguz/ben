import 'dart:convert';
import 'dart:typed_data';

import 'package:msgpack2/msgpack2.dart';

abstract class Serializable {
  Map<String, dynamic> toMap();
}

// https://stackoverflow.com/questions/56484370/how-to-declare-factory-constructor-in-abstract-classes

abstract class Serializer {
  static Uint8List toJson<T extends Serializable>(T source) {
    return utf8.encode(jsonEncode(source.toMap()));
  }

  static T fromJson<T extends Serializable>(
      Uint8List bytes, T Function(Map<String, dynamic> data) factory) {
    final json = utf8.decode(bytes);
    return factory(jsonDecode(json) as Map<String, dynamic>);
  }

  static Uint8List toMessagePack<T extends Serializable>(T source) {
    return serialize(source.toMap());
  }

  static T fromMessagePack<T extends Serializable>(
      Uint8List bytes, T Function(Map data) factory) {
    return factory(deserialize(bytes));
  }

  static Map decodeMessagePackToMap(Uint8List bytes) {
    return deserialize(bytes);
  }
}
