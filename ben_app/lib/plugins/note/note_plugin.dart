import 'package:ben_app/plugins/abstract_plugin.dart';
import 'package:ben_app/plugins/note/add_note_page.dart';
import 'package:flutter/cupertino.dart';

import 'note_model.dart';

class NotePlugin extends AbstractPlugin<NoteModel> {
  NotePlugin(int pluginId) : super(pluginId, "记事", (_) => NoteModel.fromMap(_));

  @override
  void onCreatePressed(BuildContext context) {
    print('adding note...');
    Navigator.of(context).pushNamed("/add/note");
  }

  @override
  Map<String, WidgetBuilder> routes() {
    return {"/add/note": (_) => AddNotePage()};
  }
}
