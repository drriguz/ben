import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/serialize.dart';

abstract class AbstractPlugin<T extends Serializable> {
  AbstractPlugin(this.pluginId, this.tabTitle, this.factory) {
    assert(pluginId != null);
    assert(factory != null);
  }

  final int pluginId;
  final String tabTitle;
  final T Function(Map decoded) factory;

  Future<T> decode(Item item) async {
    await Future.delayed(Duration(seconds: 1));
    return Serializer.fromMessagePack<T>(item.content, factory);
  }
}
