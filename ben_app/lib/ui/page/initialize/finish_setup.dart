import 'package:flutter/material.dart';

class FinishSetupPage extends StatelessWidget {
  final Widget buttons;

  const FinishSetupPage({Key key, this.buttons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.asset("assets/undraw_to_the_moon_v1mv.png"),
          Text("一切已经就绪，请开始使用吧！"),
          FlatButton(
            onPressed: () => {},
            child: Text("开始使用"),
            textColor: Colors.blue,
          ),
          buttons,
        ],
      ),
    );
  }
}
