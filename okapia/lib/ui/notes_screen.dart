import 'package:flutter/material.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/states/note_state.dart';
import 'package:provider/provider.dart';

import 'common/icons.dart';
import 'notes/notes_page.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          NotesPage(),
          NotesPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      title: Text(S.of(context).label_okapia),
      bottom: TabBar(
        controller: _tabController,
        tabs: [
          Tab(text: S.of(context).label_notes),
          Tab(text: S.of(context).label_passwords),
        ],
      ),
      actions: [
        IconButton(icon: Icon(FontIcon.search), onPressed: () {}),
      ],
    );
  }
}
