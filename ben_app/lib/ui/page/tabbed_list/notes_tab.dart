import 'package:ben_app/mobx/notes_store.dart';
import 'package:ben_app/ui/page/secrets/widgets/empty_list_tip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NotesListPage extends StatelessWidget {
  final NotesStore _notesStore;

  const NotesListPage(this._notesStore, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return _notesStore.isBusy
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                child: _createList(),
                onRefresh: _onRefresh,
              );
      },
    );
  }

  Future<void> _onRefresh() async {
    return _notesStore.fetch();
  }

  Widget _createList() {
    if (_notesStore.totalCount == 0)
      return EmptyListTipWidget(onRefresh: _onRefresh);
    return ListView.builder(
        itemCount: _notesStore.totalCount,
        itemBuilder: (_, int index) {
          return Text("item ${index}");
        });
  }
}
