import 'dart:typed_data';
import 'package:fast_rsa/rsa.dart';
import 'package:okapia/common/format/key_data.dart';
import 'package:okapia/common/format/protobuf/data_formats.pb.dart';
import 'package:okapia/common/sqlite/entity/header_entity.dart';
import 'package:convert/convert.dart';
import 'package:okapia/common/sqlite/entity/structured_Item_entity.dart';
import 'package:okapia/common/sqlite/repository/structured_item_repository.dart';
import 'package:okapia/common/utils/encrypter.dart';
import 'package:uuid/uuid.dart';

import '../common/sqlite/repository/header_repository.dart';
import '../common/crypto/credential.dart';
import '../common/crypto/hmac_validator.dart';
import '../common/crypto/kdf.dart';
import '../common/crypto/protected_value.dart';
import '../common/utils/random.dart';

class ChatService {
  final StructuredItemRepository _itemRepository;
  final Kdf _kdf;
  final _uuid = new Uuid();

  ChatService(this._itemRepository, this._kdf);

  Future<KeyData> generateNewKey(PasswordCredential credential) async {
    final key = await RSA.generate(4096);

    final now = DateTime.now().toIso8601String();
    KeyMetaMessage meta = KeyMetaMessage.create()
      ..createdTime = now
      ..lastUpdatedTime = now
      ..publicKey = key.publicKey;
    KeyDataMessage data = KeyDataMessage.create()..privateKey = key.privateKey;
    KeyData keyData = KeyData(id: _uuid.v4(), meta: meta, content: data);

    final encrypted = await keyData.encrypt(Encrypter(credential, _kdf));

    await _itemRepository.insert(encrypted);
    return keyData;
  }

  Future<KeyData> getActiveKey(PasswordCredential credential) async {
    final myKeys = await getMyKeys(credential);
    if (myKeys.isEmpty)
      return generateNewKey(credential);
    else {
      myKeys.sort((l, r) => r.meta.createdTime.compareTo(l.meta.createdTime));
      return myKeys[0];
    }
  }

  Future<List<KeyData>> getMyKeys(PasswordCredential credential) async {
    final encrypter = Encrypter(credential, _kdf);
    final items = await _itemRepository.getFullItemsByType(TYPE_KEY);
    final decrypted = items.map((e) async {
      encrypter.decrypt(e.content);
      return KeyData(
        id: e.id,
        type: TYPE_KEY,
        meta: KeyMetaMessage.fromBuffer(await encrypter.decrypt(e.meta)),
        content: KeyDataMessage.fromBuffer(await encrypter.decrypt(e.content)),
      );
    });
    return Future.wait(decrypted);
  }
}
