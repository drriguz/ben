import 'package:okapia/common/sqlite/entity/structured_Item_entity.dart';
import 'package:okapia/common/sqlite/entity/structured_item_brief_view.dart';
import 'package:okapia/common/utils/encrypter.dart';
import 'package:mobx/mobx.dart';

import 'protobuf/data_formats.pb.dart';

part 'note_data.g.dart';

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

class BriefNoteData = _BriefNoteData with _$BriefNoteData;

abstract class _BriefNoteData with Store {
  String id;

  @observable
  NoteMetaMessage meta;

  _BriefNoteData({this.id, this.meta});
}
