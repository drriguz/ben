import 'package:ben_app/format/serialize.dart';

abstract class AbstractDataRecord implements Serializable {
  final String id;
  final DateTime createdTime;
  final DateTime lastUpdatedTime;

  Map<String, dynamic> get meta;

  AbstractDataRecord(this.id, this.createdTime, this.lastUpdatedTime);
}
