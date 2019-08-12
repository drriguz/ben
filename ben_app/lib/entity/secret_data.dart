enum DataType {
  BANK_CARD,
  CERTIFICATE,
  MEDIA,
  PASSWORD,
  NOTE,
  FILE,
}

class SecretData {
  String id;
  DataType type;
  String value;
  String checksum;

  SecretData({this.id, this.type, this.value, this.checksum});
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
