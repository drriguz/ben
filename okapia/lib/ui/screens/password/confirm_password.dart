import 'package:flutter/material.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/ui/widgets/text_input.dart';

class ConfirmPasswordDialog extends StatelessWidget {
  final ProtectedValue expected;

  const ConfirmPasswordDialog(this.expected, {Key key}) : super(key: key);

  String _validatePassword(BuildContext context, ProtectedValue password) {
    if (password != expected) return S.of(context).password_not_match;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: Text(S.of(context).password_confirm),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: ListBody(
            children: <Widget>[
              TextInput(
                mandatory: true,
                name: S.of(context).password,
                obscureText: true,
                maxLength: 50,
                validator: (text) =>
                    _validatePassword(context, ProtectedValue.of(text)),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).save),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Navigator.of(context).pop(true);
            }
          },
        ),
      ],
    );
  }
}
