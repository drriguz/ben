import 'package:ben_app/plugins/bank_card/bank_card_model.dart';
import 'package:ben_app/util/strings.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

class BankCardItem extends GeneralIconItem<BankCardModel> {
  const BankCardItem({Key key, BankCardModel model})
      : super(key: key, model: model);

  @override
  String getDescription() {
    return Strings.masking(model.number);
  }

  @override
  ImageProvider getItemIcon() {
    return AssetImage('assets/banks/cmb.png');
  }

  @override
  String getSubtitle() {
    switch (model.type) {
      case CardType.CREDIT:
        return "信用卡";
      case CardType.DEBIT:
        return "储蓄卡";
    }
    throw new Exception("Unexpected card type");
  }

  @override
  String getTitle() {
    return model.title;
  }
}
