import 'package:ben_app/generated/i18n.dart';
import 'package:ben_app/providers/view_models/initialize_model.dart';
import 'package:ben_app/util/links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class UserAgreementPage extends StatelessWidget {
  final Widget buttons;

  const UserAgreementPage({Key key, this.buttons}) : super(key: key);

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
              Consumer<InitializeViewModel>(
                  builder: (context, viewModel, child) => Checkbox(
                        value: viewModel.acceptUserAgreement,
                        onChanged: (value) =>
                            viewModel.acceptUserAgreement = value,
                      )),
            ],
          ),
          buttons,
        ],
      ),
    );
  }
}
