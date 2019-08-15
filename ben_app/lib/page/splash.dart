import '../config/app_injector_config.dart';
import '../service/initialize_service.dart';
import '../mode/meta_data.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final InitializeService initializeService =
      InjectorHelper.get<InitializeService>();

  Future<void> _init() async {
    await initializeService.validateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          child: Image.asset("assets/splash.jpg", fit: BoxFit.cover),
          constraints: BoxConstraints.expand(),
        ),
        Image.asset(
          "assets/title.png",
          fit: BoxFit.contain,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
    Future.delayed(Duration(milliseconds: 200), () {
      Navigator.of(context).pushNamed('/home');
    });
  }
}
