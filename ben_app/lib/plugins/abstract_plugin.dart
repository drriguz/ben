import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/serialize.dart';
import 'package:flutter/material.dart';

abstract class DataModel implements Serializable {
  final String id;

  DataModel(this.id);
}

abstract class AbstractPlugin<T extends DataModel> {
  AbstractPlugin(this.pluginId, this.tabTitle, this.factory) {
    assert(pluginId != null);
    assert(factory != null);
  }

  final int pluginId;
  final String tabTitle;
  final T Function(Map decoded) factory;

  Future<T> decode(Item item) async {
    return Serializer.fromMessagePack<T>(item.content, factory);
  }

  Widget build(final T data) {
    return Container();
  }
}
