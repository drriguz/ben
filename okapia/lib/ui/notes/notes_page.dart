import 'package:flutter/material.dart';
import 'package:okapia/states/note_state.dart';
import 'package:provider/provider.dart';

import 'note_item.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NotesState>(context, listen: false).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<NotesState>(
        builder: (_, notes, child) => ListView.builder(
          itemCount: notes.items.length,
          itemBuilder: (_, int index) {
            return NoteItemWidget(notes.items[index]);
          },
        ),
      ),
    );
  }
}
