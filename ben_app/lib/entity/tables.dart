import 'dart:convert';

class MetaDataEntity {
  String name;
  List<int> value;

  MetaDataEntity(this.name, this.value);

  get stringValue {
    return utf8.decode(this.value);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }

  factory MetaDataEntity.from(Map<String, dynamic> values) {
    return MetaDataEntity(
      values['name'],
      values['value'],
    );
  }
}

enum DataType {
  BANK_CARD,
  CERTIFICATE,
  MEDIA,
  PASSWORD,
  NOTE,
  FILE,
}

class SecretDataEntity {
  String id;
  DataType type;
  List<int> content;
  List<int> checksum;

  SecretDataEntity({this.id, this.type, this.content, this.checksum});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'content': content,
      'checksum': checksum,
    };
  }

  factory SecretDataEntity.from(Map<String, dynamic> values) {
    return SecretDataEntity(
      id: values['id'],
      type: values['type'],
      content: values['content'],
      checksum: values['checksum'],
    );
  }
}