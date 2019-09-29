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

  Widget _progressBar() {
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            const CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: const Text('正在初始化，请稍后...'),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.asset("assets/undraw_to_the_moon_v1mv.png"),
          Text("一切已经就绪，请开始使用吧！"),
          Consumer<InitializeViewModel>(
            builder: (context, viewModel, child) => viewModel.isBusy
                ? Container()
                : FlatButton(
                    onPressed: () => _onStartUsingPressed(context),
                    child: Text("开始使用"),
                    textColor: Colors.blue,
                  ),
          ),
          Consumer<InitializeViewModel>(
            builder: (context, viewModel, child) =>
                viewModel.isBusy ? _progressBar() : buttons,
          ),
        ],
      ),
    );
  }
}
