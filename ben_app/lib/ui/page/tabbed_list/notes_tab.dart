import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/mobx/item_list_store.dart';
import 'package:ben_app/plugins/note/note_model.dart';
import 'package:ben_app/ui/page/secrets/widgets/empty_list_tip.dart';
import 'package:ben_app/ui/page/secrets/widgets/list_item_placeholder.dart';
import 'package:ben_app/ui/page/secrets/widgets/note_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NotesListPage extends StatelessWidget {
  final NoteStore _noteStore;

  const NotesListPage(this._noteStore, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return _noteStore.isBusy
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                child: _createList(),
                onRefresh: _onRefresh,
              );
      },
    );
  }

  Future<void> _onRefresh() async {
    return _noteStore.fetch();
  }

  Widget _createList() {
    if (_noteStore.totalCount == 0)
      return EmptyListTipWidget(onRefresh: _onRefresh);
    return ListView.builder(
        itemCount: _noteStore.totalCount,
        itemBuilder: (_, int index) {
          return _createListItem(_noteStore.data[index]);
        });
  }

  Future<NoteModel> decode(Item data) async {
    return Serializer.fromMessagePack<NoteModel>(
        data.content, (_) => NoteModel.fromMap(_));
  }

  Widget _createListItem(Item data) {
    return FutureBuilder<NoteModel>(
      future: decode(data),
      builder: (BuildContext _, AsyncSnapshot<NoteModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return NoteItem(model: snapshot.data);
          default:
            return ItemPlaceholder();
        }
      },
    );
  }
}
