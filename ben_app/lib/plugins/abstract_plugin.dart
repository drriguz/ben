import 'package:ben_app/format/serialize.dart';

abstract class AbstractPlugin<T extends Serializable> {
  String get id;

  String get tabTitle;

  const AbstractPlugin();
}
