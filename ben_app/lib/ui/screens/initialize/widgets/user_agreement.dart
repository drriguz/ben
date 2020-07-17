import 'package:ben_app/stores/initialize_store.dart';
import 'package:ben_app/generated/l10n.dart';
import 'package:ben_app/ui/utils/links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UserAgreementPage extends StatelessWidget {
  final InitializeStore _store;
  final Function onPrevious;
  final Function onNext;

  const UserAgreementPage(this._store,
      {Key key, @required this.onPrevious, @required this.onNext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Html(
            data: S.of(context).user_agreement_detail,
            onLinkTap: (url) {
              print(url);
              Links.launchURL(url);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(S.of(context).agree),
              Observer(
                builder: (_) => Checkbox(
                  value: _store.agreeUserAgreement,
                  onChanged: (value) => _store.setAgreeUserAgreement(value),
                ),
              ),
            ],
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                key: Key("previousButton"),
                onPressed: this.onPrevious,
                child: Text(S.of(context).previous),
              ),
              Observer(
                builder: (_) => FlatButton(
                  key: Key("nextButton"),
                  onPressed: _store.agreeUserAgreement ? this.onNext : null,
                  child: Text(S.of(context).next),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
