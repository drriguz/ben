import 'package:ben_app/ui/widgets/form_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddBankcardPage extends StatelessWidget {
  final _validFromController = MaskedTextController(mask: '00/00');
  final _validToController = MaskedTextController(mask: '00/00');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("添加银行卡"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            FormInput.textInput("持卡人姓名", "请输入姓名"),
            FormInput.textInput("卡号", "银行卡号"),
            FormInput.textInput("所属银行", "所属发卡行"),
            FormInput("有效期", _renderValidDate()),
            _renderCardImages(),
          ],
        ),
      ),
    );
  }

  Widget _renderValidDate() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _validFromController,
            decoration: InputDecoration.collapsed(hintText: "起 月/年"),
          ),
        ),
        Expanded(
          child: TextField(
            controller: _validToController,
            decoration: InputDecoration.collapsed(hintText: "止 月/年"),
          ),
        )
      ],
    );
  }

  Widget _renderCardImages() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Image(
                image: AssetImage('assets/front.jpg'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Image(
                image: AssetImage('assets/back.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
