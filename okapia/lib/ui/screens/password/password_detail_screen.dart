import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:okapia/common/crypto/protected_value.dart';
import 'package:okapia/common/sqlcipher/model/image.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/services/password_service.dart';
import 'package:okapia/stores/password_detail_store.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:okapia/ui/screens/password/seconday_password_input_dialog.dart';
import 'package:okapia/ui/widgets/image_card.dart';
import 'package:okapia/ui/widgets/loading.dart';
import 'package:okapia/ui/widgets/text_line.dart';
import 'package:provider/provider.dart';

class PasswordDetailScreen extends StatefulWidget {
  final int id;

  const PasswordDetailScreen(this.id, {Key key}) : super(key: key);

  @override
  _PasswordDetailScreenState createState() => _PasswordDetailScreenState();
}

class _PasswordDetailScreenState extends State<PasswordDetailScreen> {
  PasswordDetailStore _store;

  @override
  void initState() {
    super.initState();
    _store = PasswordDetailStore(
      widget.id,
      Provider.of<UserStore>(context, listen: false),
      Provider.of<PasswordService>(context, listen: false),
    );
    _store.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).view_password_detail),
      ),
      body: Observer(
        builder: (_) => _store.isBusy
            ? Loading()
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: _content(),
                ),
              ),
      ),
    );
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextLine(
          _store.data.name,
          name: S.of(context).name,
        ),
        TextLine(
          _store.data.account,
          name: S.of(context).account,
        ),
        TextLine(
          _store.data.url,
          name: S.of(context).login_url,
        ),
        Observer(
          builder: (_) => _store.secondaryPasswordVerified
              ? _showDecryptedPassword()
              : _showPasswordPlaceholders(),
        ),
      ],
    );
  }

  Widget _showPasswordPlaceholders() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: RaisedButton.icon(
                  onPressed: _onDecryptPassword,
                  color: Colors.red,
                  textColor: Colors.white,
                  icon: Icon(Icons.warning_amber_outlined),
                  label: Text(S.of(context).show_password),
                ),
              )
            ],
          ),
        ),
        _displayPassword('******'),
        _attachments(),
      ],
    );
  }

  Widget _showDecryptedPassword() {
    if (_store.decrypting)
      return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Loading(),
      );
    return Container();
  }

  Widget _displayPassword(String text) {
    return Padding(
      key: ObjectKey(text),
      padding: const EdgeInsets.only(bottom: 20),
      child: TextLine(
        text,
        name: S.of(context).password,
      ),
    );
  }

  Widget _attachments() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.0),
      itemCount: 10,
      itemBuilder: (context, index) => _createImage(null),
    );
  }

  Widget _createImage(ImageModel item) {
    return ImageCard();
  }

  Future<void> _onDecryptPassword() async {
    final secondaryPassword = await showDialog<ProtectedValue>(
      context: context,
      barrierDismissible: false,
      builder: (_) => SecondaryPasswordInputDialog(),
    );
    if (secondaryPassword != null) {
      _store.setSecondaryPassword(secondaryPassword);
    }
  }
}
