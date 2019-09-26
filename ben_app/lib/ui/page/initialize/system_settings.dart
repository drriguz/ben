import 'package:ben_app/crypto/protected_value.dart';
import 'package:provider/provider.dart';

import '../../../generated/i18n.dart';
import '../../../providers/view_models/initialize_model.dart';
import 'package:flutter/material.dart';

class SystemSettingsPage extends StatelessWidget {
  final Widget buttons;

  const SystemSettingsPage({Key key, @required this.buttons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(S.of(context).master_password_description),
          Consumer<InitializeViewModel>(
            builder: (context, viewModel, child) => TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "请设置一个主密码",
                ),
                onChanged: (password) =>
                    {viewModel.masterPassword = ProtectedValue.of(password)}),
          ),
          Consumer<InitializeViewModel>(
            builder: (context, viewModel, child) => TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "请重新输入您的主密码",
                ),
                onChanged: (password) => {
                      viewModel.confirmedMasterPassword =
                          ProtectedValue.of(password)
                    }),
          ),
          Consumer<InitializeViewModel>(
            builder: (context, viewModel, child) =>
                viewModel.passwordErrorMessage == null
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          viewModel.passwordErrorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text("您可以开启指纹验证，这样仅需要在启动应用时输入一次主密码。当您重启应用之后，需要重新输入主密码。"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("开启指纹解锁"),
              Consumer<InitializeViewModel>(
                builder: (context, viewModel, child) => Switch(
                  value: viewModel.enableFingerprint,
                  onChanged: (value) => viewModel.enableFingerprint = value,
                ),
              ),
            ],
          ),
          buttons,
        ],
      ),
    );
  }
}
