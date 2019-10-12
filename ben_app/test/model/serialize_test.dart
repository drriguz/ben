import 'dart:convert';
import 'dart:typed_data';

import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/plugins/bank_card/bank_card.dart';
import 'package:test/test.dart';

final bankCard = BankCard(
    bank: "ICBC", title: "中国工商银行", type: CardType.CREDIT, number: "1234567890");

void main() {
  test('toJson', () {
    Uint8List jsonBytes = Serializer.toJson(bankCard);
    print("serialize bankcard using json: size=${jsonBytes.length}");
    BankCard deserialized =
        Serializer.fromJson(jsonBytes, (_) => BankCard.fromMap(_));
    expect(deserialized, bankCard);
    expect(utf8.decode(jsonBytes),
        """{"bank":"ICBC","title":"中国工商银行","type":"CardType.CREDIT","number":"1234567890"}""");
  });

  test('toMessagePack', () {
    Uint8List messagePackBytes = Serializer.toMessagePack(bankCard);
    print(
        "serialize bankcard using message pack: size=${messagePackBytes.length}");
    BankCard deserialized = Serializer.fromMessagePack(
        messagePackBytes, (_) => BankCard.fromMap(_));
    expect(deserialized, bankCard);
  });
}
