import 'package:flutter/foundation.dart';
import 'package:native_sqlcipher/native_sqlcipher.dart';
import 'package:okapia/generated/l10n.dart';

import '../common/crypto/protected_value.dart';
import '../common/crypto/key.dart';
import '../services/login_service.dart';

class UserState extends ChangeNotifier {
  final LoginService _service;

  TransformedKey? _userCredential;

  TransformedKey? get userCredential => _userCredential;

  Database? _database;

  Database? get database => _database;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool _isBusy = false;

  bool get isBusy => _isBusy;

  UserState(this._service);

  void dispose() {
    super.dispose();
    _closeDatabaseConnection();
  }

  void setBusy(bool busy) {
    _isBusy = busy;
    notifyListeners();
  }

  Future<bool> login(final ProtectedValue masterPassword) async {
    assert(_userCredential == null);
    assert(_database == null);

    setBusy(true);

    bool success = false;
    try {
      final TransformedKey credential =
          await _service.checkUserCredential(masterPassword);
      _errorMessage = null;
      _userCredential = credential;
      await _createDatabaseConnection();
      success = true;
    } catch (_) {
      print(_);
      _userCredential = null;
      _errorMessage = S.current.tip_password_invalid;
    }

    setBusy(false);
    return success;
  }

  Future<void> _createDatabaseConnection() async {
    /**
     * https://github.com/simolus3/moor/issues/835
     * https://github.com/tekartik/sembast_sqflite/issues/5
     * https://github.com/dart-lang/sdk/issues/35770
     * https://github.com/tekartik/sqflite/blob/master/sqflite_common_ffi/lib/src/database_tracker.dart
     */
    _database = await _service.openSqlcipher(_userCredential!);
  }

  Future<void> _closeDatabaseConnection() async {
    print("closing existing database");
    _database?.close();
  }

  Future<void> logout() async {
    _userCredential = null;
    _closeDatabaseConnection();
  }
}
