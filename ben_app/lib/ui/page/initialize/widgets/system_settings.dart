import 'package:ben_app/backend/mobx/initialize_store.dart';
import 'package:ben_app/crypto/protected_value.dart';
import 'package:ben_app/ui/theme/styles.dart';
import 'package:ben_app/ui/widgets/setting_option.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../generated/i18n.dart';
import 'package:flutter/material.dart';

class SystemSettingsPage extends StatelessWidget {
  final InitializeStore _store;
  final Function onPrevious;
  final Function onNext;

  const SystemSettingsPage(this._store, {Key key, @required this.onPrevious, @required this.onNext}) : super(key: key);

  List<Widget> _buildPasswordInput() {
    return <Widget>[
      TextField(
        obscureText: true,
        decoration: InputDecoration(hintText: "请设置一个主密码"),
        onChanged: (value) => _store.setMasterPassword(ProtectedValue.of(value)),
      ),
      TextField(
        obscureText: true,
        decoration: InputDecoration(hintText: "请重新输入您的主密码"),
        onChanged: (value) => _store.confirmPassword(ProtectedValue.of(value)),
      ),
      Observer(
        builder: (_) => _store.errorMessage != null
            ? Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  _store.errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              )
            : Container(),
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
          SwitchOption(
            "开启指纹解锁",
            "您可以开启指纹验证，这样仅需要在启动应用时输入一次主密码。当您重启应用之后，需要重新输入主密码。",
            (_) => Switch(value: _store.enableFingerPrint, onChanged: (value) => _store.setEnableFingerPrint(value)),
          ),
          SwitchOption(
            "自动检测加密设置",
            "开启后，系统会尝试根据您的设备计算出（比默认更强的）达到要求的安全设置。如果不开启系统将会使用推荐的默认设置。",
            (_) => Switch(
                value: _store.autoDetectEncryptOptions,
                onChanged: (value) => _store.setAutoDetectEncryptOptions(value)),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                key: Key("previousButton"),
                onPressed: this.onPrevious,
                child: Text("上一步"),
              ),
              Observer(
                builder: (_) => FlatButton(
                  key: Key("nextButton"),
                  onPressed: _store.isSettingsCompleted ? this.onNext : null,
                  child: Text("下一步"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
