import 'package:ben_app/generated/i18n.dart';
import 'package:flutter/material.dart';

class UserAgreementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("同意用户协议"),
              Checkbox(
                value: false,
              ),
            ],
          ),
          Text(S.of(context).user_agreement),
        ],
      ),
    );
  }
}
