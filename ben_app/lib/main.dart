import 'package:flutter/material.dart';

import 'config/app_injector_config.dart';
import 'config/injector.dart';
import 'page/Home.dart';
import 'page/splash.dart';

void main() async{
  await InjectorHelper.registerClasses();
  //runApp(AppEntry());
}

class AppEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ben',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashPage(),
      routes: {
        "/home": (BuildContext context) => new HomePage(),
      },
    );
  }
}
