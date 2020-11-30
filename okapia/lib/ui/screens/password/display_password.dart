import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/services/password_service.dart';
import 'package:okapia/stores/password_decrypt_store.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class DisplayPasswordDialog extends StatefulWidget {
  final Uint8List data;

  const DisplayPasswordDialog(this.data, {Key key}) : super(key: key);

  @override
  _DisplayPasswordDialogState createState() => _DisplayPasswordDialogState();
}

class _DisplayPasswordDialogState extends State<DisplayPasswordDialog> {
  PasswordDecryptStore _store;

  @override
  void initState() {
    super.initState();
    _store = PasswordDecryptStore(
      widget.data,
      Provider.of<UserStore>(context, listen: false),
      Provider.of<PasswordService>(context, listen: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).show_password),
      content: SingleChildScrollView(
        child: Observer(
          builder: (_) => _store.secondaryPasswordCompleted
              ? _holdToShowPassword()
              : _pinInputContainer(context),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).cancel),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }

  Widget _pinInputContainer(BuildContext context) {
    return ListBody(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: Text(S.of(context).please_input_secondary_password),
        ),
        _pinInput(),
      ],
    );
  }

  Widget _holdToShowPassword() {
    return Text("Hold!");
  }

  Widget _pinInput() {
    final BoxDecoration decoration = BoxDecoration(
      border: Border.all(color: Colors.blueGrey),
      borderRadius: BorderRadius.circular(15.0),
    );
    return Container(
      width: 100,
      color: Colors.white,
      child: PinPut(
        fieldsCount: 4,
        obscureText: '*',
        onSubmit: (pwd) =>
            _store.submitSecondaryPassword(ProtectedValue.of(pwd)),
        submittedFieldDecoration: decoration.copyWith(
          borderRadius: BorderRadius.circular(20.0),
        ),
        selectedFieldDecoration: decoration,
        followingFieldDecoration: decoration.copyWith(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.blueGrey.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
