import 'dart:convert';

import 'package:ben_app/service/repository_factory.dart';

import '../entity/tables.dart';

import '../main.dart';
import '../service/repository.dart';

import 'package:flutter/material.dart';

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
        await RepositoryFactory.createInstance();
    await repository.createOrUpdateMetaData(
        MetaDataEntity("key", utf8.encode("hello world!我是中文")));
    List<MetaDataEntity> metas = await repository.getMetaDatas();
    print(metas[0].stringValue);
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
