import 'package:ben_app/format/serializer.dart';

abstract class AbstractMetaModel implements Serializable {
  final DateTime createdTime;
  final DateTime lastUpdatedTime;

  AbstractMetaModel(this.createdTime, this.lastUpdatedTime);
}

abstract class AbstractContentModel<T extends AbstractMetaModel> extends AbstractMetaModel {
  AbstractContentModel(DateTime createdTime, DateTime lastUpdatedTime) : super(createdTime, lastUpdatedTime);

  T createMeta();
}
