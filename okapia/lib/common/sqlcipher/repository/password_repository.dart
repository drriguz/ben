import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/sqlcipher/model/event.dart';
import 'package:okapia/common/sqlcipher/model/password.dart';
import 'package:okapia/common/sqlcipher/repository.dart';

class PasswordRepository extends Sqlite3Repository<PasswordModel> {
  PasswordRepository()
      : super(PasswordModel.TABLE, Entity.FIELDS + PasswordModel.FIELDS);

  @override
  PasswordModel merge(PasswordModel existing, PasswordModel updated) {
    existing.name = updated.name;
    existing.account = updated.account;
    existing.url = updated.url;
    existing.icon = updated.icon;
    existing.content = updated.content;
    return existing;
  }

  @override
  PasswordModel convert(Row row) {
    return PasswordModel.fromResult(row);
  }
}
