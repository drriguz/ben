import 'package:ben_app/ui/model/bank_card.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

class BankCardItem extends AbstractListItem<BankCard> {
  const BankCardItem({Key key, BankCard model})
      : super(key: key, model: model, hasDescription: true);

  @override
  Widget buildDescription() {
    return Text(
      _getDisplayCardNumber(),
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildIcon() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Image(
        image: AssetImage('assets/banks/cmb.png'),
        width: 32,
        height: 32,
      ),
    );
  }

  @override
  Widget buildTitle() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: BoxDecoration(
        border: Border(
            left: BorderSide(
          color: Colors.orange,
        )),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            model.title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          Text(
            _getCardTypeName(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  String _getCardTypeName() {
    switch (model.type) {
      case CardType.CREDIT:
        return "信用卡";
      case CardType.DEBIT:
        return "储蓄卡";
    }
    throw new Exception("Unexpected card type");
  }

  String _getDisplayCardNumber() {
    String number = "****";
    if (model.number.length > 4)
      number += " " + model.number.substring(model.number.length - 4);
    return number;
  }
}
