import 'package:ben_app/generated/i18n.dart';
import 'package:ben_app/util/links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
          Html(
            data: S.of(context).user_agreement,
            onLinkTap: (url) {
              print(url);
              Links.launchURL(url);
            },
          ),
        ],
      ),
    );
  }
}
