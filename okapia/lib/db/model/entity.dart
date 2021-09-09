abstract class Entity {
  int? id;
  int? createdTime;
  int? lastUpdatedTime;

  static final String FIELDS = "id, created_time, last_updated_time,";

  Entity(this.id, this.createdTime, this.lastUpdatedTime);

  String toSqlValues();

  String toUpdateSql();
}
