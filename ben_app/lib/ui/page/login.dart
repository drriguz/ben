import 'package:ben_app/providers/view_models/login_model.dart';
import 'package:provider/provider.dart';

import '../theme/icons.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _profileImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 200, bottom: 50.0),
      child: Image(
        image: AssetImage("assets/profile.png"),
        width: 150,
      ),
    );
  }

  Widget _input() {
    final model = Provider.of<LoginViewModel>(context);
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
            onSubmitted: this.onPasswordSubmitted,
          ),
          if (model.errorMessage != null)
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                model.errorMessage,
                style: TextStyle(color: Colors.red),
              ),
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

  void onPasswordSubmitted(String password) async {
    bool success = await Provider.of<LoginViewModel>(context, listen: false)
        .login(password);
    if (success) Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _profileImage(),
                  Consumer<LoginViewModel>(
                    builder: (context, loginViewModel, child) =>
                        loginViewModel.isBusy ? _progressBar() : _input(),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
