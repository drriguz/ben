import 'package:ben_app/generated/l10n.dart';
import 'package:ben_app/util/links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class UserAgreementPage extends StatelessWidget {
  final Function onPrevious;
  final Function onNext;

  const UserAgreementPage({Key key, @required this.onPrevious, @required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Html(
            data: S.of(context).user_agreement,
            onLinkTap: (url) {
              print(url);
              Links.launchURL(url);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("同意用户协议"),
              Checkbox(value: true),
            ],
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                key: Key("previousButton"),
                onPressed: this.onPrevious,
                child: Text("上一步"),
              ),
              FlatButton(
                key: Key("nextButton"),
                onPressed: this.onNext,
                child: Text("下一步"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
