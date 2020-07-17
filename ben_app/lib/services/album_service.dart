import 'package:ben_app/common/crypto/credential.dart';
import 'package:ben_app/common/crypto/kdf.dart';
import 'package:ben_app/common/format/album_data.dart';
import 'package:ben_app/common/format/protobuf/data_formats.pb.dart';
import 'package:ben_app/common/sqlite/repository/album_repository.dart';
import 'package:ben_app/common/utils/encrypter.dart';
import 'package:uuid/uuid.dart';

class AlbumService {
  final Kdf _kdf;
  final _uuid = new Uuid();
  final AlbumRepository _albumRepository;

  AlbumService(this._albumRepository, this._kdf);

  Future<List<AlbumData>> fetchAlbums(PasswordCredential credential) async {
    final items = await _albumRepository.getAlbums();
    final encrypter = Encrypter(credential, _kdf);
    final decrypted = items.map((e) => AlbumData.from(e, encrypter));
    return Future.wait(decrypted);
  }

  Future<AlbumData> fetch(String id, PasswordCredential credential) async {
    final record = await _albumRepository.getById(id);
    assert(record != null);

    return AlbumData.from(record, Encrypter(credential, _kdf));
  }

  Future<AlbumData> create(PasswordCredential credential, String name) async {
    assert(name != null);

    final now = DateTime.now().toIso8601String();
    AlbumMessage message = AlbumMessage.create();
    message.name = name;
    message.createdTime = now;
    message.lastUpdatedTime = now;

    AlbumData data = AlbumData(id: _uuid.v4(), content: message);
    final encrypted = await data.encrypt(Encrypter(credential, _kdf));
    await _albumRepository.insert(encrypted);
    return data;
  }

  Future<AlbumData> update(
      PasswordCredential credential, AlbumData data) async {
    assert(data != null && data.id != null);

    final now = DateTime.now().toIso8601String();
    data.content.lastUpdatedTime = now;

    final encrypted = await data.encrypt(Encrypter(credential, _kdf));

    await _albumRepository.update(encrypted);
    return data;
  }
}
