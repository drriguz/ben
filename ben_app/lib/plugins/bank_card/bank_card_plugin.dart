import 'package:ben_app/plugins/abstract_plugin.dart';
import 'package:ben_app/plugins/bank_card/bank_card_model.dart';
import 'package:ben_app/ui/page/secrets/widgets/bank_card_item.dart';
import 'package:flutter/material.dart';

class BankCardPlugin extends AbstractPlugin<BankCardModel> {
  BankCardPlugin(int pluginId)
      : super(pluginId, "卡片", (_) => BankCardModel.fromMap(_));

  @override
  Widget build(BankCardModel data) {
    return BankCardItem(key: ObjectKey(data.id), model: data);
  }
}
