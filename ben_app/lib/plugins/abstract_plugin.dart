import 'package:ben_app/format/serialize.dart';

abstract class AbstractPlugin<T extends Serializable> {
  const AbstractPlugin(this.pluginId, this.tabTitle);

  final int pluginId;
  final String tabTitle;
}
