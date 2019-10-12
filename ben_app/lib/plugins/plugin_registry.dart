import 'package:ben_app/plugins/abstract_plugin.dart';
import 'package:ben_app/plugins/bank_card/bank_card_plugin.dart';
import 'package:ben_app/plugins/certificate/certificate_plugin.dart';

import 'option.dart';

class PluginRegistry {
  static const List<AbstractPlugin> supportedPlugins = [
    const BankCardPlugin(1),
    const CertificatePlugin(2),
  ];

  static List<Option<int>> getTabNames() {
    return supportedPlugins
        .map((plugin) => Option<int>(plugin.tabTitle, plugin.pluginId))
        .toList();
  }

  static AbstractPlugin getPlugin(int id) {
    return supportedPlugins.firstWhere((plugin) => plugin.pluginId == id);
  }
}
