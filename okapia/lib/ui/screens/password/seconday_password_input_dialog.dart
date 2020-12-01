import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/services/login_service.dart';
import 'package:okapia/services/password_service.dart';
import 'package:okapia/stores/secondary_password_input_store.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:okapia/ui/widgets/loading.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class SecondaryPasswordInputDialog extends StatefulWidget {
  final String title;

  const SecondaryPasswordInputDialog({Key key, this.title}) : super(key: key);

  @override
  _SecondaryPasswordInputDialogState createState() =>
      _SecondaryPasswordInputDialogState();
}

class _SecondaryPasswordInputDialogState
    extends State<SecondaryPasswordInputDialog> {
  SecondaryPasswordInputStore _store;

  @override
  void initState() {
    super.initState();
    _store = SecondaryPasswordInputStore(
      Provider.of<LoginService>(context, listen: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title ?? S.of(context).show_password),
      content: SingleChildScrollView(
        child: _pinInputContainer(context),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).cancel),
          onPressed: () {
            Navigator.of(context).pop(null);
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
        Container(
          height: 50,
          child: Observer(
            builder: (_) {
              if (_store.isChecking) return Loading();
              if (_store.error != null)
                return Text(_store.error,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .apply(color: Colors.red));
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget _pinInput() {
    final BoxDecoration decoration = BoxDecoration(
      border:
          const Border(bottom: BorderSide(color: Colors.blueGrey, width: 2)),
    );
    return Container(
      width: 100,
      color: Colors.white,
      child: PinPut(
        autofocus: true,
        fieldsCount: 6,
        obscureText: '*',
        onSubmit: (pwd) => _onSubmitPassword(ProtectedValue.of(pwd)),
        submittedFieldDecoration: const BoxDecoration(
          border: null,
        ),
        selectedFieldDecoration: decoration,
        followingFieldDecoration: decoration,
      ),
    );
  }

  Future<void> _onSubmitPassword(ProtectedValue password) async {
    final secondaryKey = await _store.submitSecondaryPassword(password);
    if (secondaryKey != null) Navigator.of(context).pop(secondaryKey);
  }
}
