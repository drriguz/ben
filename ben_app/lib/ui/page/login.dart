import '../theme/icons.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: Image(
              image: AssetImage("assets/profile.png"),
              width: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10.0, 50, 10),
            child: TextField(
              obscureText: true,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "请输入查询密码以解锁",
                prefixIcon: Icon(
                  FontIcon.lock,
                  color: Colors.red,
                  size: 22.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
