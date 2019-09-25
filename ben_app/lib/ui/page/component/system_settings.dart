import 'package:ben_app/generated/i18n.dart';
import 'package:flutter/material.dart';

class SystemSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(S.of(context).master_password_description),
          TextField(
            obscureText: true,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "请设置一个主密码",
            ),
          ),
          TextField(
            obscureText: true,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "请重新输入您的主密码",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              "密码不正确",
              style: TextStyle(color: Colors.red),
            ),
          ),
          Text("您可以开启指纹验证，这样仅需要在启动应用时输入一次主密码。当您重启应用之后，需要重新输入主密码。"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("开启指纹解锁"),
              Switch(
                value: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
