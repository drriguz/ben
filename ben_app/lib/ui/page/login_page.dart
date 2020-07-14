import 'package:ben_app/backend/store/user_store.dart';
import 'package:ben_app/crypto/protected_value.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../theme/icons.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final UserStore _userStore;

  const LoginPage(this._userStore, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _profileImage(),
                  Observer(
                    builder: (_) {
                      return _userStore.isBusy
                          ? _progressBar()
                          : _input(context);
                    },
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget _profileImage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Image(
        image: AssetImage("assets/profile.png"),
        width: 150,
      ),
    );
  }

  Widget _input(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10.0, 50, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            obscureText: true,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "请输入主密码解锁",
              suffixIcon: Icon(
                FontIcon.lock,
                color: Colors.red,
                size: 22.0,
              ),
            ),
            onSubmitted: (_) => this.onPasswordSubmitted(context, _),
          ),
          Observer(
            builder: (_) {
              if (_userStore.hasError)
                return Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    _userStore.errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                );
              else
                return Container();
            },
          )
        ],
      ),
    );
  }

  Widget _progressBar() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(50, 100.0, 50, 10),
        child: Column(
          children: <Widget>[
            const CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: const Text('解锁中，请稍后...'),
            ),
          ],
        ));
  }

  void onPasswordSubmitted(BuildContext context, String password) async {
    print('login with: ${password}');
    bool success = await _userStore.login(ProtectedValue.of(password));
    if (success) Navigator.pushReplacementNamed(context, "/home");
  }
}
