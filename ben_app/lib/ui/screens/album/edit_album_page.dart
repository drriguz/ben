import 'package:ben_app/backend/common/services/item_service.dart';
import 'package:ben_app/backend/stores/item_detail_store.dart';
import 'package:ben_app/backend/stores/item_list_store.dart';
import 'package:ben_app/backend/stores/user_store.dart';
import 'package:ben_app/ui/widgets/form_input.dart';
import 'package:ben_app/ui/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAlbumPage extends StatefulWidget {
  final String _id;

  EditAlbumPage(this._id, {Key key}) : super(key: key);

  @override
  _EditAlbumPageState createState() => _EditAlbumPageState(_id);
}

class _EditAlbumPageState extends State<EditAlbumPage> {
  final String _id;
  TextEditingController _textEditingController;

  NoteDetailStore _detailStore;

  _EditAlbumPageState(this._id);

  bool _isCreating() {
    return _id == null;
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _detailStore = new NoteDetailStore(
      Provider.of<UserStore>(context, listen: false),
      Provider.of<ItemService>(context, listen: false),
      Provider.of<NoteStore>(context, listen: false),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_id != null) _detailStore.fetch(_id);
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCreating() ? "创建相册" : "编辑相册"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            FormInput(
              "创建一个相册用来归类您的照片，相册名称可以随意填写。系统将自动生成唯一的ID来进行区分，即使您创建了相同名称的相册也不会混淆",
              "相册名称",
              _textEditingController,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: _createToolbar(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createToolbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
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
      Toasts.showError("相册名称不能为空", null);
      return;
    }

    AlbumStore albumStore = Provider.of<AlbumStore>(context);
    return albumStore
        .createOrUpdate(_id, _textEditingController.text)
        .then((_) => Navigator.of(context).pop())
        .catchError((e) => Toasts.showError("保存失败，请重试", e));
  }
}
