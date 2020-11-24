import 'package:okapia/common/sqlcipher/model/password.dart';
import 'package:okapia/common/sqlcipher/repository/password_repository.dart';

import 'curd_service.dart';

class PasswordService extends CurdService<PasswordModel, PasswordRepository> {
  PasswordService(PasswordRepository repository) : super(repository);
}
