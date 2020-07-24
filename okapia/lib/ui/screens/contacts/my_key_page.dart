import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:okapia/services/chat_service.dart';
import 'package:okapia/stores/chat_qr_store.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okapia/ui/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyKeyPage extends StatefulWidget {
  const MyKeyPage({Key key}) : super(key: key);

  @override
  _MyKeyPageState createState() => _MyKeyPageState();
}

class _MyKeyPageState extends State<MyKeyPage> {
  ChatQrStore _qrStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("我的口令")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("您的口令（公钥）可以直接发给任何人，对方可以通过Okapia扫码添加您的公钥并使用这个公钥发送加密后的内容给您。\n但这只能让其他人将信息加密发给您，若您也同时需要向他人发送信息，则需要扫描对方的信息；或者让对方在发送信息时，附带自己的公钥信息。"),
          ),
          Observer(
            builder: (_) => _qrStore.isBusy ? Loading() : _renderQr(),
          )
        ],
      ),
    );
  }

  Widget _renderQr() {
    return Center(
      child: QrImage(
        embeddedImage: AssetImage("assets/logo.png"),
        data: _qrStore.myKey,
        version: QrVersions.auto,
        size: 300.0,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _qrStore = ChatQrStore(
      Provider.of<UserStore>(context, listen: false),
      Provider.of<ChatService>(context, listen: false),
    );
    _qrStore.fetch();
  }
}
