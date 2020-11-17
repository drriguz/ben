import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:okapia/ui/utils/toast.dart';

import '../../main.dart';
import '../theme/icons.dart';


class LoginScreen extends StatefulWidget {
  final UserStore _userStore;

  const LoginScreen(this._userStore, {Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with RouteAware {
  FocusNode _inputFocusNode;
  FToast _fToast;

  @override
  void initState() {
    super.initState();
    _inputFocusNode = new FocusNode();
    _fToast = FToast();
    _fToast.init(context);
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
      body: SingleChildScrollView(
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
    );
  }

  Widget _profileImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 50.0),
      child: Image(
        image: AssetImage("assets/images/profile.png"),
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
              hintText: S.of(context).please_input_master_password,
              suffixIcon: Icon(
                FontIcon.lock,
                color: Colors.red,
                size: 22.0,
              ),
            ),
            onSubmitted: (_) => this.onPasswordSubmitted(context, _),
          ),
        ],
      ),
    );
  }

  Widget _progressBar() {
    return Column(
      children: <Widget>[
        const CircularProgressIndicator(),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(S.current.unlocking),
          ),
        ),
      ],
    );
  }

  void onPasswordSubmitted(BuildContext context, String password) async {
    if (password == null || password.length < 6) {
      _showErrorToast(S.of(context).password_too_short);
      return;
    }
    FocusScope.of(context).unfocus();
    bool success = await widget._userStore.login(ProtectedValue.of(password));
    if (success)
      Navigator.pushReplacementNamed(context, "/home");
    else
      _showErrorToast(S.of(context).password_validation_failed);
  }

  void _showErrorToast(final String message) {
    _fToast.showToast(
      child:
          Toasts.createCustomToast(message, backgroundColor: Colors.redAccent),
      toastDuration: Duration(seconds: 2),
    );
  }
}
