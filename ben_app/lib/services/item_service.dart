import 'package:ben_app/common/crypto/credential.dart';
import 'package:ben_app/common/crypto/kdf.dart';
import 'package:ben_app/common/format/note_data.dart';
import 'package:ben_app/common/format/protobuf/data_formats.pb.dart';
import 'package:ben_app/common/sqlite/entity/structured_Item_entity.dart';
import 'package:ben_app/common/sqlite/repository/structured_item_repository.dart';
import 'package:ben_app/common/utils/encrypter.dart';
import 'package:uuid/uuid.dart';

class ItemService {
  final StructuredItemRepository _itemRepository;
  final Kdf _kdf;

  final _uuid = new Uuid();

  ItemService(this._itemRepository, this._kdf);

  Future<NoteData> createNote(
      String content, PasswordCredential credential) async {
    final data = _createNote(content);
    final encrypted = await data.encrypt(Encrypter(credential, _kdf));
    await _itemRepository.insert(encrypted);

    return data;
  }

  Future<NoteData> updateNote(
      String id, String content, PasswordCredential credential) async {
    final oldNote = await fetchNote(id, credential);
    oldNote.meta.lastUpdatedTime = DateTime.now().toIso8601String();

    final data = _update(oldNote, content);
    final encrypted = await data.encrypt(Encrypter(credential, _kdf));
    await _itemRepository.update(encrypted);
    return data;
  }

  Future<void> delete(String id) async {
    return _itemRepository.delete(id);
  }

  Future<List<BriefNoteData>> fetchNotes(PasswordCredential credential) async {
    final items = await _itemRepository.getItemsByType(TYPE_NOTE);
    final encrypter = Encrypter(credential, _kdf);
    final decrypted = items.map((e) => BriefNoteData.from(e, encrypter));
    return Future.wait(decrypted);
  }

  Future<NoteData> fetchNote(String id, PasswordCredential credential) async {
    final record = await _itemRepository.getByIdAndType(id, TYPE_NOTE);
    assert(record != null);

    return NoteData.from(record, Encrypter(credential, _kdf));
  }

  NoteData _update(NoteData old, String content) {
    assert(old != null && content != null);
    final lines = content.split("\n");
    final title = lines.firstWhere((line) => line.isNotEmpty);
    final currentTime = DateTime.now().toIso8601String();

    old.meta.lastUpdatedTime = currentTime;
    old.meta.title = title;

    old.content.content = content;
    return old;
  }

  NoteData _createNote(String content) {
    assert(content != null);

    final lines = content.split("\n");
    final title = lines.firstWhere((line) => line.isNotEmpty);
    final currentTime = DateTime.now().toIso8601String();
    final NoteMetaMessage metaMessage = NoteMetaMessage.create();
    final NoteDataMessage dataMessage = NoteDataMessage.create();
    metaMessage.createdTime = currentTime;
    metaMessage.lastUpdatedTime = currentTime;
    metaMessage.title = title;

    dataMessage.content = content;

    return NoteData(
        id: _uuid.v4(),
        type: TYPE_NOTE,
        meta: metaMessage,
        content: dataMessage);
  }
}
