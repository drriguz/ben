import '../theme/icons.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isUnlocking = false;

  Widget _profileImage() {
    return Image(
      image: AssetImage("assets/profile.png"),
      width: 150,
    );
  }

  Widget _input() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10.0, 50, 10),
      child: TextField(
        obscureText: true,
        autofocus: true,
        decoration: InputDecoration(
          hintText: "请输入查询密码以解锁",
          suffixIcon: Icon(
            FontIcon.lock,
            color: Colors.red,
            size: 22.0,
          ),
        ),
        onSubmitted: this.onPasswordSubmitted,
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
    _isUnlocking = true;
    print(password);
    await Future.delayed(Duration(milliseconds: 40));
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _profileImage(),
                  if (_isUnlocking) _progressBar() else _input(),
                ],
              ),
            ),
          ],
        ));
  }
}
