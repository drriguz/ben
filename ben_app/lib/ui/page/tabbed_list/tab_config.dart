import 'package:ben_app/format/serialize.dart';
import 'package:ben_app/plugins/bank_card/bank_card_model.dart';
import 'package:ben_app/plugins/certificate/certificate_model.dart';
import 'package:ben_app/plugins/note/note_model.dart';
import 'package:ben_app/providers/services/item_list_service.dart';
import 'package:ben_app/providers/view_models/tabbed_list_model.dart';
import 'package:ben_app/ui/page/secrets/widgets/bank_card_item.dart';
import 'package:ben_app/ui/page/secrets/widgets/certificate_card_item.dart';
import 'package:ben_app/ui/page/secrets/widgets/note_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'list_view.dart';

SingleChildCloneableWidget Function()
    provide<T extends AbstractTabbedListViewModel<T>>(
        Function(ItemListService service) constructor) {
  return () => ChangeNotifierProxyProvider<ItemListService, T>(
        builder: (_, service, viewModel) => constructor(service),
      );
}

final List<TabConfig> supportedTabs = [
  BankCardTabConfig(),
  CertificateTabConfig(),
  NoteTabConfig(),
];

class ListViewModelConsumer<T extends AbstractTabbedListViewModel<T>> {}

abstract class TabConfig<T extends AbstractTabbedListViewModel<T>,
    M extends Serializable> {
  final SingleChildCloneableWidget Function() viewModelProvider;

  final String tabTitle;

  final ItemListView<T, M> Function(TabConfig config) tabContentProvider;

  final M Function(Map data) modelConstructor;

  final Widget Function(M model) itemViewBuilder;

  final String addPageRoute;

  TabConfig(
    this.tabTitle,
    this.viewModelProvider,
    this.tabContentProvider,
    this.modelConstructor,
    this.itemViewBuilder,
    this.addPageRoute,
  );

  T getViewModel(BuildContext context, bool listen) {
    return Provider.of<T>(context, listen: listen);
  }

  Future<void> persist(BuildContext context, M item) {}
}

class BankCardTabConfig
    extends TabConfig<BankCardListViewModel, BankCardModel> {
  BankCardTabConfig()
      : super(
          "卡片",
          provide<BankCardListViewModel>((_) => BankCardListViewModel(_)),
          (_) => ItemListView<BankCardListViewModel, BankCardModel>(config: _),
          (_) => BankCardModel.fromMap(_),
          (_) => BankCardItem(model: _),
          "/bankcard/add",
        );
}

class CertificateTabConfig
    extends TabConfig<CertificateListViewModel, CertificateModel> {
  CertificateTabConfig()
      : super(
          "证件",
          provide<CertificateListViewModel>((_) => CertificateListViewModel(_)),
          (_) => ItemListView<CertificateListViewModel, CertificateModel>(
              config: _),
          (_) => CertificateModel.fromMap(_),
          (_) => CertificateCardItem(model: _),
          "/certificate/add",
        );
}

class NoteTabConfig extends TabConfig<NoteListViewModel, NoteModel> {
  NoteTabConfig()
      : super(
          "记事",
          provide<NoteListViewModel>((_) => NoteListViewModel(_)),
          (_) => ItemListView<NoteListViewModel, NoteModel>(config: _),
          (_) => NoteModel.fromMap(_),
          (_) => NoteItem(model: _),
          "/note/add",
        );
}
