import 'package:flutter/material.dart';

class ToolConfig {
  final String title;
  final String subTitle;
  final String icon;

  const ToolConfig(this.title, this.subTitle, this.icon);
}

const tools = [
  ToolConfig(
    "Password Generator",
    "帮你生成理想的随机密码",
    "assets/password-dict.png",
  ),
  ToolConfig(
    "卡片识别",
    "识别您的银行卡",
    "assets/scan.png",
  ),
];

class ToolboxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("工具箱"),
        ),
        body: ListView.builder(
          itemCount: tools.length,
          itemBuilder: _itemBuilder,
        ));
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final config = tools[index];
    return ToolItem(config: config);
  }
}

class ToolItem extends StatelessWidget {
  final ToolConfig config;

  const ToolItem({Key key, this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image(
          image: AssetImage(config.icon),
          width: 50,
        ),
        title: Text(
          config.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          config.subTitle,
          style: TextStyle(fontSize: 14),
        ),
        trailing: Icon(Icons.expand_more),
      ),
    );
  }
}
