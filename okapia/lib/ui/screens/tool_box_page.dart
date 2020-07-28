import 'package:flutter/material.dart';

class ToolConfig {
  final String title;
  final String subTitle;
  final String icon;
  final String route;

  const ToolConfig(this.title, this.subTitle, this.icon, this.route);
}

const tools = [
  ToolConfig(
    "Password Generator",
    "帮你生成理想的随机密码",
    "assets/icons/password-dict.png",
    "/tools/password_generator",
  ),
  ToolConfig(
    "扫一扫",
    "识别隐藏在图片里面的信息",
    "assets/icons/scan.png",
    "/tools/scan",
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
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(config.route),
      child: Card(
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
      ),
    );
  }
}
