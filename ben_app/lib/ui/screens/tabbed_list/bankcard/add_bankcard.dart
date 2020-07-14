import 'package:ben_app/ui/widgets/form_input.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'scan_card.dart';

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
            FormInput("卡号", _renderCardNumber(context)),
            FormInput.textInput("所属银行", "所属发卡行"),
            FormInput("有效期", _renderValidDate()),
            _renderCardImages(),
          ],
        ),
      ),
    );
  }

  Widget _renderCardNumber(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "银行卡号",
        suffixIcon: IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () => onStartScan(context),
        ),
        border: InputBorder.none,
      ),
    );
  }

  Future<void> onStartScan(BuildContext context) async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ScanPage(
                camera: cameras.first,
              )));
    } else {
      Fluttertoast.showToast(
          msg: "无法检测到摄像头",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }

  Widget _renderValidDate() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _validFromController,
            decoration: InputDecoration(
              hintText: "起 月/年",
              border: InputBorder.none,
            ),
          ),
        ),
        Expanded(
          child: TextField(
            controller: _validToController,
            decoration: InputDecoration(
              hintText: "止 月/年",
              border: InputBorder.none,
            ),
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
              padding: const EdgeInsets.only(right: 15.0),
              child: Image(
                image: AssetImage('assets/front.jpg'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
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
