import 'dart:convert';
import 'dart:typed_data';

import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/ui/model/bank_card.dart';
import 'package:test/test.dart';

final bankCard = BankCard(
    bank: "ICBC", title: "中国工商银行", type: CardType.CREDIT, number: "1234567890");

void main() {
  test('toJson', () {
    Uint8List jsonBytes = Serializer.toJson(bankCard);
    BankCard deserialized =
        Serializer.fromJson(jsonBytes, (_) => BankCard.fromMap(_));
    expect(deserialized, bankCard);
    expect(utf8.decode(jsonBytes),
        """{"bank":"ICBC","title":"中国工商银行","type":"CardType.CREDIT","number":"1234567890"}""");
  });

  test('toMessagePack', () {
    Uint8List messagePackBytes = Serializer.toMessagePack(bankCard);
    BankCard deserialized = Serializer.fromMessagePack(
        messagePackBytes, (_) => BankCard.fromMap(_));
    expect(deserialized, bankCard);
  });
}
