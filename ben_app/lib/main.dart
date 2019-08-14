import 'package:flutter/material.dart';

import 'config/injector.dart';
import 'page/Home.dart';

final Injector injector = Injector();

void main() => runApp(AppEntry());

class AppEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ben',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}
