import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../main.dart';
import '../theme/icons.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final UserStore _userStore;

  const LoginPage(this._userStore, {Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with RouteAware {
  FocusNode _inputFocusNode;

  @override
  void initState() {
    super.initState();
    _inputFocusNode = new FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _inputFocusNode.dispose();
    super.dispose();
  }

  @override
  void didPush() {
    _inputFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _profileImage(),
              Observer(
                builder: (_) {
                  return widget._userStore.isBusy
                      ? _progressBar()
                      : _input(context);
                },
              )
            ],
          ),
        ),
      ),
    );
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
            focusNode: _inputFocusNode,
            obscureText: true,
            autofocus: false,
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
              if (widget._userStore.hasError)
                return Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    widget._userStore.errorMessage,
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
    FocusScope.of(context).unfocus();
    bool success = await widget._userStore.login(ProtectedValue.of(password));
    if (success) Navigator.pushReplacementNamed(context, "/home");
  }
}
