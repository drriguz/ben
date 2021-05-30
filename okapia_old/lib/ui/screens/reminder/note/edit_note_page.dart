import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/services/note_service.dart';
import 'package:okapia/stores/note_detail_store.dart';
import 'package:okapia/stores/note_store.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:okapia/ui/widgets/loading.dart';
import 'package:okapia/ui/widgets/tool_button.dart';
import 'package:okapia/ui/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class EditNotePage extends StatefulWidget {
  final int _id;

  EditNotePage(this._id, {Key? key}) : super(key: key);

  @override
  _EditNotePageState createState() => _EditNotePageState(_id);
}

class _EditNotePageState extends State<EditNotePage> {
  final int _id;
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
      Provider.of<NoteService>(context, listen: false),
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
    _textEditingController.text = _detailStore.data?.content;
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              style: const TextStyle(color: Colors.grey),
              controller: _textEditingController,
              expands: true,
              autofocus: true,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 1024,
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

  void _appendText(final String text) {
    _textEditingController.text = _textEditingController.text + text;
    _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textEditingController.text.length));
  }

  Widget _createToolButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ToolButton(
            label: "粘贴",
            icon: Icons.paste_outlined,
            onTap: () async {
              final ClipboardData data = await Clipboard.getData('text/plain');
              _appendText(data.text);
            }),
        ToolButton(
            label: "清空",
            icon: Icons.clear_outlined,
            onTap: () {
              _textEditingController.clear();
            }),
        ToolButton(
            label: "时间",
            icon: Icons.timer,
            onTap: () {
              final DateTime now = DateTime.now();
              _appendText(now.toIso8601String() + "\n");
            }),
        ToolButton(
            label: "位置",
            icon: Icons.navigation_outlined,
            onTap: () async {
              Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high);
              _appendText(position.toString() + "\n");
            }),
        ToolButton(
            label: "序号",
            icon: Icons.list_outlined,
            onTap: () {
              _appendText("§ ");
            }),
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
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 8.0),
          child: Container(
            height: 20,
            child: VerticalDivider(
              color: Colors.red,
            ),
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
      Toasts.showError(Toasts.showError(S.of(context).content_is_empty));
      return;
    }

    NoteStore noteStore = Provider.of<NoteStore>(context, listen: false);
    if (_isCreating())
      return noteStore
          .create(_textEditingController.text)
          .then((_) => Navigator.of(context).pop())
          .catchError((e, stack) => Toasts.showError(S.of(context).save_failed,
              error: e, stackTrace: stack));
    else
      return noteStore
          .update(_id, _textEditingController.text)
          .then((_) => Navigator.of(context).pop())
          .catchError((e, stack) => Toasts.showError(S.of(context).save_failed,
              error: e, stackTrace: stack));
  }
}
