import 'dart:typed_data';

import '../entity.dart';

class ContactEntity extends Entity<String> {
  String name;
  String publicKey;
  String fingerprint;

  ContactEntity({String id, this.name, this.publicKey, this.fingerprint}) : super(id);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'public_key': publicKey,
      'fingerprint': fingerprint,
    };
  }

  factory ContactEntity.from(Map<String, dynamic> values) {
    assert(values != null);
    return ContactEntity(
      id: values['id'],
      name: values['name'],
      publicKey: values['publicKey'],
      fingerprint: values['fingerprint'],
    );
  }
}
