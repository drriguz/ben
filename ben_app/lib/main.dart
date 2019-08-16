import 'package:flutter/material.dart';

import 'config/app_injector_config.dart';
import 'config/injector.dart';
import 'page/Home.dart';
import 'page/initialize.dart';
import 'page/splash.dart';
import 'service/initialize_service.dart';

void main() async {
  await InjectorHelper.registerClasses();
  InitializeService initService = InjectorHelper.get<InitializeService>();
  await initService.validateDataBase();
  runApp(AppEntry(
    hasInitialized: false,
  ));
}

class AppEntry extends StatelessWidget {
  final bool hasInitialized;

  const AppEntry({Key key, this.hasInitialized}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ben',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: "/",
      routes: {
        "/": (_) => hasInitialized ? new HomePage() : new InitializePage(),
        "/home": (_) => new HomePage(),
      },
    );
  }
}
