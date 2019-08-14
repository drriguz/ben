import 'dart:convert';

enum BankCardType {
  CREDIT,
  DEBIT,
}

enum CertificateType {
  ID_CARD,
  PASSPORT,
  DRIVERS_LICENSE,
}

abstract class Decrypted {
  final List<int> blob;
  final String json;

  Decrypted(this.blob) : json = utf8.decode(blob);

  List<int> serialize();
}

abstract class Unique {
  String id;
}

abstract class Serializable {
  List<int> serialize();
}

class BankCardModel extends Unique {
  BankCardType cardType;
  String number;
  String title;
  String validThru;
  String repaymentThru;
  String ownerName;
  String cvv2;
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
