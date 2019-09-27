import 'package:ben_app/providers/view_models/initialize_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinishSetupPage extends StatelessWidget {
  final Widget buttons;

  const FinishSetupPage({Key key, this.buttons}) : super(key: key);

  Future<void> _onStartUsingPressed(BuildContext context) async {
    await Provider.of<InitializeViewModel>(context, listen: false).initialize();
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.asset("assets/undraw_to_the_moon_v1mv.png"),
          Text("一切已经就绪，请开始使用吧！"),
          FlatButton(
            onPressed: () => _onStartUsingPressed(context),
            child: Text("开始使用"),
            textColor: Colors.blue,
          ),
          buttons,
        ],
      ),
    );
  }
}
