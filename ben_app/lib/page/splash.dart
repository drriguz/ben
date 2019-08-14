import 'package:flutter/material.dart';

import '../main.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
    Future.delayed(Duration(milliseconds: 3000), () {
      Navigator.of(context).pushNamed('/home');
    });
  }
}
