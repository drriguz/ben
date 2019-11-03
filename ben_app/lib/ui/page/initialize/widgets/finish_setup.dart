import 'package:ben_app/backend/mobx/initialize_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FinishSetupPage extends StatelessWidget {
  final InitializeStore _store;
  final Widget buttons;

  const FinishSetupPage(this._store, {Key key, this.buttons}) : super(key: key);

  Future<void> _onStartUsingPressed(BuildContext context) async {
    await _store.initialize();
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
      child: Observer(
        builder: (_) => Column(
          children: <Widget>[
            Image.asset("assets/undraw_to_the_moon_v1mv.png"),
            Text("一切已经就绪，请开始使用吧！"),
            if (!_store.isBusy)
              FlatButton(
                onPressed: () => _onStartUsingPressed(context),
                child: Text("开始使用"),
                textColor: Colors.blue,
              ),
            if (_store.isBusy) _progressBar()
          ],
        ),
      ),
    );
  }
}
