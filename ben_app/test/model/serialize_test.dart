import 'dart:convert';
import 'dart:typed_data';

import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/ui/model/bank_card_model.dart';
import 'package:test/test.dart';

final bankCard = BankCardModel(
    bank: "ICBC", title: "中国工商银行", type: CardType.CREDIT, number: "1234567890");

void main() {
  test('toJson', () {
    Uint8List jsonBytes = Serializer.toJson(bankCard);
    print("serialize bankcard using json: size=${jsonBytes.length}");
    BankCardModel deserialized =
        Serializer.fromJson(jsonBytes, (_) => BankCardModel.fromMap(_));
    expect(deserialized, bankCard);
    expect(utf8.decode(jsonBytes),
        """{"bank":"ICBC","title":"中国工商银行","type":"CardType.CREDIT","number":"1234567890"}""");
  });

  test('toMessagePack', () {
    Uint8List messagePackBytes = Serializer.toJson(bankCard);
    print(
        "serialize bankcard using message pack: size=${messagePackBytes.length}");
    BankCardModel deserialized = Serializer.fromJson(
        messagePackBytes, (_) => BankCardModel.fromMap(_));
    expect(deserialized, bankCard);
  });
}
