import 'package:ben_app/ui/model/bank_card_model.dart';
import 'package:test/test.dart';

final bankCard = BankCardModel(
    bank: "ICBC", title: "中国工商银行", type: CardType.CREDIT, number: "1234567890");

final map = {
  'bank': 'ICBC',
  'title': '中国工商银行',
  'type': "CardType.CREDIT",
  'number': '1234567890'
};

void main() {
  test('toMap', () {
    expect(bankCard.toMap(), map);
  });

  test('fromMap', () {
    expect(BankCardModel.fromMap(map), bankCard);
  });
}
