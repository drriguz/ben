import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:okapia/generated/l10n.dart';

import '../common/crypto/protected_value.dart';
import '../states/user_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _inputFocusNode = new FocusNode();

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
            Consumer<UserState>(
              builder: (_, state, child) {
                return state.isBusy ? _progressBar() : _input(_);
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
              hintText: S.of(context).tip_input_password,
              suffixIcon: Icon(
                Icons.lock_open,
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
            child: Text(S.current.description_unlocking),
          ),
        ),
      ],
    );
  }

  void onPasswordSubmitted(BuildContext context, String password) async {
    UserState state = Provider.of(context, listen: false);
    bool success = await state.login(ProtectedValue.of(password));
    if (success) Navigator.pushReplacementNamed(context, "/home");
  }
}
