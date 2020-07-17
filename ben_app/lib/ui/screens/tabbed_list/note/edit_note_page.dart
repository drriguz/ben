import 'package:ben_app/services/item_service.dart';
import 'package:ben_app/stores/note_detail_store.dart';
import 'package:ben_app/stores/note_store.dart';
import 'package:ben_app/stores/user_store.dart';
import 'package:ben_app/ui/theme/icons.dart';
import 'package:ben_app/ui/widgets/loading.dart';
import 'package:ben_app/ui/widgets/tool_button.dart';
import 'package:ben_app/ui/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class EditNotePage extends StatefulWidget {
  final String _id;

  EditNotePage(this._id, {Key key}) : super(key: key);

  @override
  _EditNotePageState createState() => _EditNotePageState(_id);
}

class _EditNotePageState extends State<EditNotePage> {
  final String _id;
  TextEditingController _textEditingController;

  NoteDetailStore _detailStore;

  _EditNotePageState(this._id);

  bool _isCreating() {
    return _id == null;
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _detailStore = new NoteDetailStore(
      _id,
      Provider.of<UserStore>(context, listen: false),
      Provider.of<ItemService>(context, listen: false),
    );
    if (_id != null) _detailStore.fetch();
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
        title: Text(_isCreating() ? "创建新记事" : "编辑记事"),
      ),
      body: Observer(
        builder: (_) => _detailStore.isBusy ? Loading() : _createEditor(),
      ),
    );
  }

  Widget _createEditor() {
    _textEditingController.text = _detailStore.data?.content?.content;
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
          child: _createToolbar(context),
        ),
      ],
    );
  }

  Widget _createToolButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ToolButton(label: "手写", icon: FontIcon.handWrite, onTap: () {}),
        ToolButton(label: "图片", icon: FontIcon.image, onTap: () {}),
        ToolButton(label: "视频", icon: FontIcon.video, onTap: () {}),
        ToolButton(label: "录音", icon: FontIcon.audio, onTap: () {}),
        ToolButton(label: "Markdown", icon: FontIcon.markdown, onTap: () {}),
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

  Future<void> _onSave(BuildContext context) async {
    final String content = _textEditingController.text;
    if (content == null || content.trim().isEmpty) {
      Toasts.showError("内容不能为空");
      return;
    }

    NoteStore noteStore = Provider.of<NoteStore>(context);
    if (_isCreating())
      return noteStore
          .create(_textEditingController.text)
          .then((_) => Navigator.of(context).pop())
          .catchError((e, stack) =>
              Toasts.showError("保存失败，请重试", error: e, stackTrace: stack));
    else
      return noteStore
          .update(_id, _textEditingController.text)
          .then((_) => Navigator.of(context).pop())
          .catchError((e, stack) =>
              Toasts.showError("保存失败，请重试", error: e, stackTrace: stack));
  }
}
