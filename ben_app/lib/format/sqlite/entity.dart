abstract class Entity<ID> {
  ID id;

  Entity(this.id);

  Map<String, dynamic> toMap();
}
