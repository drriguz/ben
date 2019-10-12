import 'package:ben_app/crypto/protected_value.dart';
import 'package:ben_app/ui/theme/styles.dart';
import 'package:provider/provider.dart';

import '../../../../generated/i18n.dart';
import '../../../../providers/view_models/initialize_model.dart';
import 'package:flutter/material.dart';

class SystemSettingsPage extends StatelessWidget {
  final Widget buttons;

  const SystemSettingsPage({Key key, @required this.buttons}) : super(key: key);

  List<Widget> _buildPasswordInput() {
    return <Widget>[
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
    ];
  }

  List<Widget> _buildSwitch(String text, String name) {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text(
          text,
          style: Styles.descriptionStyle,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(name),
          Consumer<InitializeViewModel>(
            builder: (context, viewModel, child) => Switch(
              value: viewModel.enableFingerprint,
              onChanged: (value) => viewModel.enableFingerprint = value,
            ),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            S.of(context).master_password_description,
            style: Styles.descriptionStyle,
          ),
          ..._buildPasswordInput(),
          ..._buildSwitch(
            "您可以开启指纹验证，这样仅需要在启动应用时输入一次主密码。当您重启应用之后，需要重新输入主密码。",
            "开启指纹解锁",
          ),
          ..._buildSwitch(
            "开启后，系统会尝试根据您的设备计算出（比默认更强的）达到要求的安全设置。如果不开启系统将会使用推荐的默认设置。",
            "自动检测加密设置",
          ),
          buttons,
        ],
      ),
    );
  }
}
