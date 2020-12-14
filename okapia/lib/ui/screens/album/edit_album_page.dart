import 'package:okapia/generated/l10n.dart';
import 'package:okapia/services/album_service.dart';
import 'package:okapia/stores/album_detail_store.dart';
import 'package:okapia/stores/album_store.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:okapia/ui/widgets/form_input.dart';
import 'package:okapia/ui/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class EditAlbumPage extends StatefulWidget {
  final int _id;

  EditAlbumPage(this._id, {Key key}) : super(key: key);

  @override
  _EditAlbumPageState createState() => _EditAlbumPageState(_id);
}

class _EditAlbumPageState extends State<EditAlbumPage> {
  final int _id;
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
      appBar: AppBar(
          actions: [
            FlatButton(
              onPressed: () => _onSave(context),
              child: Text(S.of(context).save),
            ),
          ],
          title: Text(_isCreating()
              ? S.of(context).creating_album
              : S.of(context).editing_album)),
      body: Observer(builder: (_) => _createEditor()),
    );
  }

  Widget _createEditor() {
    _textEditingController.text = _detailStore.data?.name;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: Column(
        children: <Widget>[
          FormInput(
            S.of(context).album_description,
            S.of(context).album_name,
            _textEditingController,
          ),
        ],
      ),
    );
  }

  Future<void> _onSave(BuildContext context) async {
    final String content = _textEditingController.text;
    if (content == null || content.trim().isEmpty) {
      Toasts.showError(S.of(context).content_is_empty);
      return;
    }

    AlbumStore albumStore = Provider.of<AlbumStore>(context);
//    if (_isCreating())
//      return albumStore
//          .create(_textEditingController.text)
//          .then((_) => Navigator.of(context).pop())
//          .catchError((e, s) => Toasts.showError(S.of(context).save_failed,
//              error: e, stackTrace: s));
//    else
//      return albumStore
//          .update(_id, _textEditingController.text)
//          .then((_) => Navigator.of(context).pop())
//          .catchError((e, s) => Toasts.showError(S.of(context).save_failed,
//              error: e, stackTrace: s));
  }
}
