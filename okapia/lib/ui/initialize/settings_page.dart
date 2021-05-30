import 'package:flutter/material.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/states/InitializationState.dart';
import 'package:provider/provider.dart';
import '../common/text_input.dart';
import '../../common/crypto/protected_value.dart';

class SettingPage extends StatefulWidget {
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const SettingPage({Key? key, required this.onPrevious, required this.onNext})
      : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _formKey = GlobalKey<FormState>();
  ProtectedValue? _masterPassword;
  ProtectedValue? _secondaryPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Column(children: [
          Text(S.of(context).description_master_password),
          TextInput(
            obscureText: true,
            mandatory: true,
            name: S.of(context).label_master_password,
            hint: S.of(context).helper_valid_password,
            maxLength: 20,
            validator: (text) {
              if (text == null || text.length < 6)
                return S.of(context).tip_password_too_short;
              return null;
            },
            onChanged: (text) {
              _masterPassword = ProtectedValue.of(text);
            },
          ),
          Text(S.of(context).description_secondary_password),
          TextInput(
            obscureText: true,
            name: S.of(context).label_secondary_password,
            hint: S.of(context).helper_valid_password,
            maxLength: 6,
            onChanged: (text) {
              _secondaryPassword = ProtectedValue.of(text);
            },
            validator: (text) {
              if (text == null || text.length != 6)
                return S.of(context).tip_password_too_short;
              return null;
            },
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: widget.onPrevious,
                child: Text(S.of(context).button_previous),
              ),
              TextButton(
                onPressed: _onNext,
                child: Text(S.of(context).button_next),
              )
            ],
          )
        ]),
      ),
    );
  }

  void _onNext() {
    if (!_formKey.currentState!.validate()) return;
    Provider.of<InitializationState>(context, listen: false)
        .setPassword(_masterPassword!, _secondaryPassword!);
    widget.onNext();
  }
}
