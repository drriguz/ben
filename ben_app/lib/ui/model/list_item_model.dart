class ListItemModel<T> {
  final String id;
  final T meta;

  ListItemModel(this.id, this.meta);

  bool get isLoading => meta == null;
}
