import 'package:ben_app/plugins/abstract_plugin.dart';
import 'package:ben_app/plugins/bank_card/bank_card_model.dart';

class BankCardPlugin extends AbstractPlugin<BankCardModel> {
  BankCardPlugin(int pluginId)
      : super(pluginId, "卡片", (_) => BankCardModel.fromMap(_));
}
