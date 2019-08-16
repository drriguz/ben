import 'package:flutter/material.dart';

import 'config/app_injector_config.dart';
import 'ui/page/Home.dart';
import 'ui/page/initialize.dart';
import 'logic/service/initialize_service.dart';

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
