import 'abstract_model.dart';

class ListItemModel<T extends AbstractMetaModel> {
  final String id;
  final T meta;

  ListItemModel(this.id, this.meta);
}
