import 'package:ben_app/format/serialize.dart';

/**
 * Ref:https://ccdcapi.alipay.com/validateAndCacheCardInfo.json?cardNo=6222005865412565805&cardBinCheck=true
 */
enum CardType {
  DEBIT,
  CREDIT,
}

class BankCardModel extends Serializable {
  final String id;
  final String bank;
  final String title;
  final CardType type;
  final String number;

  BankCardModel({this.id, this.bank, this.title, this.type, this.number});

  factory BankCardModel.fromMap(Map map) {
    assert(map != null);
    return BankCardModel(
      id: map["id"],
      bank: map["bank"],
      title: map["title"],
      type: _parseType(map["type"]),
      number: map["number"],
    );
  }

  static CardType _parseType(String value) {
    return CardType.values.firstWhere((type) => type.toString() == value);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "bank": bank,
      "title": title,
      "type": type.toString(),
      "number": number,
    };
  }
}
