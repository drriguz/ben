import 'package:ben_app/common/sqlite/entity/structured_Item_entity.dart';
import 'package:ben_app/common/sqlite/entity/structured_item_brief_view.dart';
import 'package:ben_app/common/utils/encrypter.dart';

import 'protobuf/data_formats.pb.dart';

class NoteData {
  String id;
  int type;
  NoteMetaMessage meta;
  NoteDataMessage content;

  NoteData({this.id, this.type, this.meta, this.content});

  Future<StructuredItemEntity> encrypt(Encrypter encrypter) async {
    return StructuredItemEntity(
        id: id,
        type: TYPE_NOTE,
        meta: await encrypter.encrypt(meta.writeToBuffer()),
        content: await encrypter.encrypt(content.writeToBuffer()));
  }

  static Future<NoteData> from(
      StructuredItemEntity entity, Encrypter encrypter) async {
    NoteMetaMessage metaMessage =
        NoteMetaMessage.fromBuffer(await encrypter.decrypt(entity.meta));
    NoteDataMessage dataMessage =
        NoteDataMessage.fromBuffer(await encrypter.decrypt(entity.content));
    return NoteData(id: entity.id, meta: metaMessage, content: dataMessage);
  }
}

class BriefNoteData {
  String id;

  NoteMetaMessage meta;

  BriefNoteData({this.id, this.meta});

  static Future<BriefNoteData> from(MetaView view, Encrypter encrypter) async {
    NoteMetaMessage metaMessage =
        NoteMetaMessage.fromBuffer(await encrypter.decrypt(view.meta));
    return BriefNoteData(id: view.id, meta: metaMessage);
  }

  factory BriefNoteData.fromFullRecord(NoteData data) {
    return BriefNoteData(id: data.id, meta: data.meta);
  }
}
