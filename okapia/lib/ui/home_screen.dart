import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okapia/generated/l10n.dart';

import 'icons.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello!"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(FontIcon.list), label: S.of(context).label_notes),
          BottomNavigationBarItem(
              icon: Icon(FontIcon.message), label: S.of(context).label_chat),
          BottomNavigationBarItem(
              icon: Icon(FontIcon.calendar), label: S.of(context).label_minder),
          BottomNavigationBarItem(
              icon: Icon(FontIcon.toolbox), label: S.of(context).label_tools),
        ],
      ),
    );
  }
}
