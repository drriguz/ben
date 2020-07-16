import 'abstract_data_model.dart';

class ListItemModel<T extends StructuredMeta> {
  final String id;
  final T meta;

  ListItemModel(this.id, this.meta);

  bool get isLoading => meta == null;
}
