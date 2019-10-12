import 'package:ben_app/plugins/abstract_plugin.dart';

class BankCardPlugin extends AbstractPlugin {
  @override
  String get id => "BANK_CARD";

  @override
  String get tabTitle => "卡片";

  const BankCardPlugin() : super();
}
