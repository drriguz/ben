import '../serializer.dart';

abstract class StructuredMeta implements Serializable {
  final DateTime createdTime;
  final DateTime lastUpdatedTime;

  StructuredMeta(this.createdTime, this.lastUpdatedTime);
}

abstract class StructuredContent<T extends StructuredMeta> extends StructuredMeta {
  StructuredContent(DateTime createdTime, DateTime lastUpdatedTime) : super(createdTime, lastUpdatedTime);

  T createMeta();
}
