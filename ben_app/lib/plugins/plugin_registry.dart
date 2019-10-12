import 'package:ben_app/plugins/abstract_plugin.dart';
import 'package:ben_app/plugins/bank_card/bank_card_plugin.dart';
import 'package:ben_app/plugins/certificate/certificate_plugin.dart';

import 'option.dart';

class PluginRegistry {
  static const List<AbstractPlugin> supportedPlugins = [
    const BankCardPlugin(),
    const CertificatePlugin(),
  ];

  static List<Option<String>> getTabNames() {
    return supportedPlugins
        .map((plugin) => Option<String>(plugin.id, plugin.tabTitle))
        .toList();
  }
}
