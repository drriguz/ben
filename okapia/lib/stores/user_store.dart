import 'package:native_sqlcipher/database.dart';
import 'package:okapia/common/crypto/key.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/services/login_service.dart';

import '../common/crypto/protected_value.dart';
import 'package:mobx/mobx.dart';

import 'page_status_notifier.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore extends PageStatusNotifier with Store {
  final LoginService _loginService;

  TransformedKey _userCredential;

  TransformedKey get userCredential => _userCredential;

  Database _database;

  Database get database => _database;

  bool isPausedToTakePhoto = false;

  @observable
  String _errorMessage;

  String get errorMessage => _errorMessage;

  @computed
  bool get hasError => _errorMessage != null;

  _UserStore(this._loginService)
      : _userCredential = null,
        _errorMessage = null,
        _database = null,
        super();

  void dispose() {
    if (_database != null) {
      print("closing database connection.");
      _database.close();
    }
  }

  Future<void> closeCrashedConnection() async {}

  @action
  Future<bool> login(final ProtectedValue masterPassword) async {
    assert(_userCredential == null);
    assert(_database == null);

    setBusy();
    bool success = false;
    try {
      final TransformedKey credential =
          await _loginService.checkUserCredential(masterPassword);
      _errorMessage = null;
      _userCredential = credential;
      await _createDatabaseConnection();
      success = true;
    } catch (_) {
      print(_);
      _userCredential = null;
      _errorMessage = S.current.password_validation_failed;
    }
    setIdle();
    return success;
  }

  static final String DB_ADDRESS = "gc.keep";

  Future<void> _createDatabaseConnection() async {
    /**
     * https://github.com/simolus3/moor/issues/835
     * https://github.com/tekartik/sembast_sqflite/issues/5
     * https://github.com/dart-lang/sdk/issues/35770
     * https://github.com/tekartik/sqflite/blob/master/sqflite_common_ffi/lib/src/database_tracker.dart
     */
    _database = await _loginService.openSqlcipher(_userCredential);
  }

  Future<void> _closeDatabaseConnection() async {
    print("closing existing database");
    _database.close();
    _database = null;
  }

  Future<void> logout() async {
    _userCredential = null;
    _closeDatabaseConnection();
  }
}
