import 'package:ben_app/providers/view_models/item_list_model.dart';
import 'package:ben_app/plugins/certificate/certificate_card.dart';
import 'package:ben_app/ui/widget/bank_card_item.dart';
import 'package:ben_app/ui/widget/certificate_card_item.dart';
import 'package:provider/provider.dart';

import '../../plugins/bank_card/bank_card.dart';
import '../model/choice.dart';
import '../theme/icons.dart';
import '../widget/search_bar.dart';

import 'package:flutter/material.dart';

import 'not_implemented.dart';

class ItemListPage extends StatefulWidget {
  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

const List<MenuChoice> menuItems = const <MenuChoice>[
  const MenuChoice('关于', 'about', Icons.directions_car),
  const MenuChoice('分享', 'share', Icons.directions_bus),
  const MenuChoice('反馈', 'feedback', Icons.directions_railway),
  const MenuChoice('偏好设置', 'settings', Icons.directions_walk),
  const MenuChoice('检查更新', 'update', Icons.directions_walk),
];

const List<TabChoice> tabItems = const <TabChoice>[
  const TabChoice('卡片', SecretListType.CARD),
  const TabChoice('证书', SecretListType.CERTIFICATE),
  const TabChoice('媒体', SecretListType.MEDIA),
  const TabChoice('密码', SecretListType.PASSWORD),
  const TabChoice('记事', SecretListType.NOTE),
  const TabChoice('文件', SecretListType.FILE),
];

class _ItemListPageState extends State<ItemListPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  void _onPressed() {}

  void _onDropdownSelected(MenuChoice choice) {}

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabItems.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TabBar _createTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: tabItems.map(
        (TabChoice tabItem) {
          return new Tab(text: tabItem.option);
        },
      ).toList(),
    );
  }

  Widget _createList(TabChoice choice) {
    print("rendering...${choice.value}");
    if (choice.value == SecretListType.CARD) {
      return Consumer<ItemListViewModel>(
        builder: (_, viewModel, child) => viewModel.isBusy
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: viewModel.data.length,
                itemBuilder: (_, int index) {
                  return BankCardItem(
                    key: ObjectKey(index),
                    model: BankCard(
                        bank: 'ICBC',
                        type: CardType.CREDIT,
                        title: '中国工商银行',
                        number: '6222005865412565805'),
                  );
                }),
      );
    }
    if (choice.value == SecretListType.CERTIFICATE) {
      return ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return CertificateCardItem(
              key: ObjectKey(index),
              model: CertificateCard(
                title: '李海峰',
                type: CertificateCardType.ID,
                number: '422822199109111031',
              ),
            );
          });
    }
    return NotImplementedPage(title: choice.option);
  }

  TabBarView _createTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: tabItems.map(
        (TabChoice tabItem) {
          return _createList(tabItem);
        },
      ).toList(),
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      title: Stack(
        children: <Widget>[
          Center(
            child: SearchBar(),
          )
        ],
      ),
      bottom: _createTabBar(),
      actions: <Widget>[
        IconButton(icon: Icon(FontIcon.backup), onPressed: _onPressed),
        PopupMenuButton<MenuChoice>(
          onSelected: _onDropdownSelected,
          itemBuilder: (BuildContext context) {
            return menuItems.map((MenuChoice choice) {
              return PopupMenuItem<MenuChoice>(
                value: choice,
                child: ListTile(
                  leading: Icon(choice.icon),
                  title: Text(choice.option),
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: _createTabBarView(),
    );
  }
}
