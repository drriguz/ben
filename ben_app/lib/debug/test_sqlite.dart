import 'package:ben_app/service/repository_factory.dart';

import '../entity/meta_data.dart';
import '../entity/secret_data.dart';

import '../service/sqlite3_repository.dart';
import '../service/repository.dart';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SecretEntity {
  final int id;
  final String title;
  final List<int> content;

  SecretEntity({this.id, this.title, this.content});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}

class DebugPage extends StatelessWidget {
  DebugPage();

  void test() async {
    AbstractRepository repository =
        await RepositoryFactory.createInstance("test.db");
    List<MetaDataEntity> metas = await repository.getMetaDatas();
    print(metas);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: Text('Test'),
          onPressed: () => test(),
        ),
        const Text('Hello world!'),
      ],
    );
  }
}
