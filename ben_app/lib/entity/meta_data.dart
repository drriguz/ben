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
