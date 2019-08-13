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

enum BankCardType {
  CREDIT,
  DEBIT,
}

enum CertificateType {
  ID_CARD,
  PASSPORT,
  DRIVERS_LICENSE,
}

class Pictures {
  String positiveImage;
  String negativeImage;
}

class Password {
  String hint;
  String password;
}

class BankCardEntity with Pictures, Password {
  BankCardType cardType;
  String number;
  String title;
  String validThru;
  String repaymentThru;
  String ownerName;
  String cvv2;
}

class CertificateEntity with Pictures {
  String name;
  String number;
  String validThru;
  CertificateType certificateType;
}

class FileEntity {
  String fileName;
  int size;
  String data;
}

class MediaEntity extends FileEntity {
  String thumbnailImage;
}

class NoteEntity {
  String title;
  String content;
  DateTime createDate;
}

class PasswordEntity extends NoteEntity with Password {}
