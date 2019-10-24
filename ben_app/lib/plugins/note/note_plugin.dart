import 'package:ben_app/plugins/abstract_plugin.dart';
import 'package:ben_app/plugins/note/add_note_page.dart';
import 'package:ben_app/providers/services/item_list_service.dart';
import 'package:ben_app/providers/view_models/add_note_model.dart';
import 'package:ben_app/ui/page/secrets/widgets/note_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

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
    return {
      "/add/note": (_) =>
          ChangeNotifierProxyProvider<ItemListService, AddNoteViewModel>(
            builder: (_, service, viewModel) => AddNoteViewModel(service),
            child: AddNotePage(),
          )
    };
  }

  @override
  Widget build(final NoteModel data) {
    return NoteItem(model: data);
  }
}
