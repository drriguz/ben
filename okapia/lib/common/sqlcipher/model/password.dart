import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:native_sqlcipher/database.dart';

import '../repository.dart';

class PasswordModel extends Entity {
  String name;
  String account;
  String url;
  Uint8List icon;
  Uint8List content;

  static final String TABLE = "password";
  static final String FIELDS = "name, account, url, icon, content";

  PasswordModel(
      {int id,
      this.name,
      this.account,
      this.url,
      this.icon,
      this.content,
      int createdTime,
      int lastUpdatedTime})
      : super(id, createdTime, lastUpdatedTime);

  static PasswordModel fromResult(Row r) {
    return PasswordModel(
      id: r.readColumnAsInt("id"),
      name: r.readColumnAsText("name"),
      account: r.readColumnAsText("account"),
      url: r.readColumnAsText("url"),
      icon: r.readColumnAsBytes("icon"),
      content: r.readColumnAsBytes("content"),
      createdTime: r.readColumnAsInt64("created_time"),
      lastUpdatedTime: r.readColumnAsInt64("last_updated_time"),
    );
  }

  @override
  String toSqlValues() {
    return "'$name', '$account', '$url', x'${hex.encode(icon)}', x'${hex.encode(content)}'";
  }

  @override
  String toUpdateSql() {
    return "name='$name', account='$account', url='$url', icon=x'${hex.encode(icon)}', content=x'${hex.encode(content)}'";
  }
}
