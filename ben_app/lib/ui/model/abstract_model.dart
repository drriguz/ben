import 'package:ben_app/format/serialize.dart';

abstract class AbstractModel extends Serializable {
  final String id;
  final DateTime createdTime;
  final DateTime lastUpdatedTime;

  AbstractModel({this.id, this.createdTime, this.lastUpdatedTime});
}
