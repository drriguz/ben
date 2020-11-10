import 'package:fast_rsa/rsa.dart';
import 'package:flutter/services.dart';
import 'package:okapia/stores/chat_store.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:okapia/ui/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String _id;

  ChatPage(this._id, {Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState(_id);
}

class _ChatPageState extends State<ChatPage> {
  final String _id;
  TextEditingController _textEditingController;

  ChatStore _chatStore;

  _ChatPageState(this._id);

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _chatStore = new ChatStore(
      _id,
      Provider.of<UserStore>(context, listen: false),
    );
    _chatStore.fetch();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Observer(
        builder: (_) => _chatStore.isBusy
            ? Text("")
            : Text("与${_chatStore.contact.name}的聊天"),
      )),
      body: Observer(
        builder: (_) => _chatStore.isBusy ? Loading() : _createEditor(),
      ),
    );
  }

  Widget _createEditor() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _textEditingController,
              expands: true,
              autofocus: false,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration.collapsed(hintText: '在这里输入文字'),
            ),
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("内容经过加密后，可以通过任何方式发送给对方，对方亦仅只有通过Okapia进行解密。"),
              Text("* 注意: 本功能仅供技术验证之用，请勿非法使用"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: _createToolbar(context),
        ),
      ],
    );
  }

  Widget _createToolbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Text("附带我的公钥"),
        ),
        Container(
          height: 20,
          child: VerticalDivider(
            color: Colors.red,
          ),
        ),
        FlatButton(
          onPressed: () => _onEncrypt(context),
          textColor: Colors.blue,
          child: Text(
            "加密到剪切板",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Future<void> _onEncrypt(BuildContext context) async {
    var result = await RSA.generate(2048);
    print(result.publicKey);

    final e = await RSA.encryptPKCS1v15(
        _textEditingController.text, result.publicKey);
    print(e);
    Clipboard.setData(new ClipboardData(text: e));
  }
}
