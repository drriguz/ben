import '../serializer.dart';

abstract class Entity<ID> implements Serializable {
  ID id;

  Entity(this.id);
}