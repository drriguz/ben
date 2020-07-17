import 'dart:convert';
import 'dart:typed_data';

import '../format/protobuf/data_formats.pb.dart';

abstract class Serializable {
  Map<String, dynamic> toJson();
}

// https://stackoverflow.com/questions/56484370/how-to-declare-factory-constructor-in-abstract-classes

abstract class Serializer {
  static Uint8List toJson<T extends Serializable>(T source) {
    return utf8.encode(jsonEncode(source.toJson()));
  }

  static Uint8List toJsonRaw(Map<String, dynamic> source) {
    return utf8.encode(jsonEncode(source));
  }

  static T fromJson<T extends Serializable>(
      Uint8List bytes, T Function(Map<String, dynamic> data) factory) {
    final json = utf8.decode(bytes);
    return factory(jsonDecode(json) as Map<String, dynamic>);
  }
}
