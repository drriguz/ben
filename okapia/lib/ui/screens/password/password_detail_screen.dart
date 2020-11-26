import 'package:flutter/material.dart';
import 'package:okapia/generated/l10n.dart';

class PasswordDetailScreen extends StatelessWidget {
  final int id;

  const PasswordDetailScreen(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).view_password_detail),
      ),
      body: Text("detail"),
    );
  }
}
