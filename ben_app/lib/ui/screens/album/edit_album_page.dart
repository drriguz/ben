import 'package:ben_app/services/album_service.dart';
import 'package:ben_app/stores/album_detail_store.dart';
import 'package:ben_app/stores/album_store.dart';
import 'package:ben_app/stores/user_store.dart';
import 'package:ben_app/ui/widgets/form_input.dart';
import 'package:ben_app/ui/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class EditAlbumPage extends StatefulWidget {
  final String _id;

  EditAlbumPage(this._id, {Key key}) : super(key: key);

  @override
  _EditAlbumPageState createState() => _EditAlbumPageState(_id);
}

class _EditAlbumPageState extends State<EditAlbumPage> {
  final String _id;
  AlbumDetailStore _detailStore;
  TextEditingController _textEditingController;

  _EditAlbumPageState(this._id);

  bool _isCreating() {
    return _id == null;
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _detailStore = new AlbumDetailStore(
      _id,
      Provider.of<UserStore>(context, listen: false),
      Provider.of<AlbumService>(context, listen: false),
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
      appBar: AppBar(title: Text(_isCreating() ? "创建相册" : "编辑相册")),
      body: Observer(builder: (_) => _createEditor()),
    );
  }

  Widget _createEditor() {
    _textEditingController.text = _detailStore.data?.content?.name;
    return Padding(
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
      Toasts.showError("相册名称不能为空");
      return;
    }

    AlbumStore albumStore = Provider.of<AlbumStore>(context);
    if (_isCreating())
      return albumStore
          .create(_textEditingController.text)
          .then((_) => Navigator.of(context).pop())
          .catchError(
              (e, s) => Toasts.showError("保存失败，请重试", error: e, stackTrace: s));
    else
      return albumStore
          .update(_id, _textEditingController.text)
          .then((_) => Navigator.of(context).pop())
          .catchError(
              (e, s) => Toasts.showError("保存失败，请重试", error: e, stackTrace: s));
  }
}
