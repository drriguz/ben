import 'package:ben_app/service/init_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/provider_setup.dart';
import 'ui/page/Home.dart';
import 'ui/page/initialize.dart';
import 'ui/page/login.dart';

void main() async {
  // call InitService here
  runApp(AppEntry(
    hasInitialized: true,
  ));
}

class AppEntry extends StatelessWidget {
  final bool hasInitialized;

  const AppEntry({Key key, this.hasInitialized}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'ben',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        routes: {
          "/": (_) => hasInitialized ? new LoginPage() : new InitializePage(),
          "/login": (_) => new LoginPage(),
          "/home": (_) => new HomePage(),
        },
      ),
    );
  }
}
