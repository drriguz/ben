import 'package:ben_app/backend/store/item_list_store.dart';
import 'package:ben_app/backend/store/user_store.dart';
import 'package:ben_app/backend/services/note_service.dart';
import 'package:ben_app/ui/theme/icons.dart';
import 'package:ben_app/ui/widgets/tool_button.dart';
import 'package:ben_app/util/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditNotePage extends StatelessWidget {
  final UserStore _userStore;
  final NoteStore _noteStore;
  final NoteService _noteService;
  final TextEditingController _textEditingController = TextEditingController();

  final String _id;

  EditNotePage(this._noteStore, this._userStore, this._noteService, this._id, {Key key}) : super(key: key);

  bool _isCreating() {
    return _id == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCreating() ? "创建新记事" : "编辑记事"),
      ),
      body: Column(
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
            child: _createToolbar(context),
          ),
        ],
      ),
    );
  }

  Widget _createToolButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ToolButton(
          label: "手写",
          icon: FontIcon.handWrite,
          onTap: () {},
        ),
        ToolButton(
          label: "图片",
          icon: FontIcon.image,
          onTap: () {},
        ),
        ToolButton(
          label: "视频",
          icon: FontIcon.video,
          onTap: () {},
        ),
        ToolButton(
          label: "录音",
          icon: FontIcon.audio,
          onTap: () {},
        ),
        ToolButton(
          label: "Markdown",
          icon: FontIcon.markdown,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _createToolbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: _createToolButtons(),
        ),
        Container(
          height: 20,
          child: VerticalDivider(
            color: Colors.red,
          ),
        ),
        FlatButton(
          onPressed: () => _onSave(context),
          textColor: Colors.blue,
          child: Text(
            "保存",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  void _onSave(BuildContext context) async {
    final String content = _textEditingController.text;
    if (content == null || content.trim().isEmpty) {
      Toasts.showError("内容不能为空", null);
      return;
    }

    _noteStore
        .save(_noteService.createNote(_textEditingController.text), _userStore.userCredential)
        .then((_) => Navigator.of(context).pop())
        .catchError((e) => Toasts.showError("保存失败，请重试", e));
  }
}
