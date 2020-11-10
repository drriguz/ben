class NoteModel {
  String id;
  String title;
  String content;
  DateTime createdTime;
  DateTime lastUpdatedTime;

  NoteModel(
      {this.id,
      this.title,
      this.content,
      this.createdTime,
      this.lastUpdatedTime});
}
