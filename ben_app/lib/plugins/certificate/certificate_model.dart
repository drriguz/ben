import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/plugins/abstract_plugin.dart';

enum CertificateType {
  ID,
  DRIVER_LICENSE,
  VEHICLE_LICENSE,
  PASSPORT,
}

class CertificateModel extends DataModel {
  final String title;
  final CertificateType type;
  final String number;

  CertificateModel({String id, this.title, this.type, this.number}) : super(id);

  factory CertificateModel.fromMap(Map map) {
    assert(map != null);
    return CertificateModel(
      id: map["id"],
      title: map["title"],
      type: _parseType(map["type"]),
      number: map["number"],
    );
  }

  static CertificateType _parseType(String value) {
    return CertificateType.values
        .firstWhere((type) => type.toString() == value);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "type": type.toString(),
      "number": number,
    };
  }
}
