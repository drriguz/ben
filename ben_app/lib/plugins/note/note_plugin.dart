import 'package:ben_app/plugins/abstract_plugin.dart';

import 'note_model.dart';

class NotePlugin extends AbstractPlugin<NoteModel> {
  NotePlugin(int pluginId) : super(pluginId, "记事", (_) => NoteModel.fromMap(_));
}
