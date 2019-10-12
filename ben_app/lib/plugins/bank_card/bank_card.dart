import 'dart:typed_data';

import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/format/serialize.dart';

/**
 * Ref:https://ccdcapi.alipay.com/validateAndCacheCardInfo.json?cardNo=6222005865412565805&cardBinCheck=true
 */
enum CardType {
  DEBIT,
  CREDIT,
}

class BankCard implements Serializable {
  final String bank;
  final String title;
  final CardType type;
  final String number;

  const BankCard({this.bank, this.title, this.type, this.number});

  factory BankCard.fromMap(Map map) {
    assert(map != null);
    return BankCard(
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
  Map<String, dynamic> toMap() {
    return {
      "bank": bank,
      "title": title,
      "type": type.toString(),
      "number": number,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankCard &&
          runtimeType == other.runtimeType &&
          bank == other.bank &&
          title == other.title &&
          type == other.type &&
          number == other.number;

  @override
  int get hashCode =>
      bank.hashCode ^ title.hashCode ^ type.hashCode ^ number.hashCode;
}
