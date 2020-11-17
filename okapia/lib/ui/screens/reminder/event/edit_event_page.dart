import 'package:intl/intl.dart';
import 'package:okapia/generated/l10n.dart';
import 'package:okapia/services/event_service.dart';
import 'package:okapia/stores/event_detail_store.dart';
import 'package:okapia/stores/event_store.dart';
import 'package:okapia/stores/user_store.dart';
import 'package:okapia/ui/widgets/loading.dart';
import 'package:okapia/ui/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class EditEventPage extends StatefulWidget {
  final int _id;

  EditEventPage(this._id, {Key key}) : super(key: key);

  @override
  _EditEventPageState createState() => _EditEventPageState(_id);
}

class _EditEventPageState extends State<EditEventPage> {
  DateTime _currentTime = DateTime.now();
  final int _id;
  TextEditingController _eventTitleController;
  static final DateFormat displayDateFormat = DateFormat("yyyy-MM-dd");

  EventDetailStore _detailStore;

  _EditEventPageState(this._id);

  bool _isCreating() {
    return _id == null;
  }

  @override
  void initState() {
    super.initState();
    _eventTitleController = TextEditingController();
    _detailStore = new EventDetailStore(
      _id,
      Provider.of<UserStore>(context, listen: false),
      Provider.of<EventService>(context, listen: false),
    );
    if (_id != null) _detailStore.fetch();
  }

  @override
  void dispose() {
    _eventTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCreating()
            ? S.of(context).creating_event
            : S.of(context).editing_event),
        actions: [
          FlatButton(
            onPressed: () => _onSave(context),
            child: Text(S.of(context).save),
          )
        ],
      ),
      body: Observer(
        builder: (_) => _detailStore.isBusy ? Loading() : _createEditor(),
      ),
    );
  }

  Widget _createEditor() {
    _eventTitleController.text = _detailStore.data?.title;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
                controller: _eventTitleController,
                decoration: InputDecoration(
                    hintText: S.of(context).please_input_title)),
            _datetimePicker(),
            Divider(),
            FlatButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.add,
                ),
                label: Text(S.of(context).create_checklist)),
          ],
        ),
      ),
    );
  }

  Widget _datetimePicker() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: RaisedButton(
                onPressed: _showDatePicker,
                child: Text(displayDateFormat.format(_detailStore.selectedDate),
                    style: const TextStyle(fontSize: 16)),
              ),
            ),
          ),
          RaisedButton(
            onPressed: _showTimePicker,
            child: Text(_detailStore.selectedTime.format(context),
                style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _currentTime,
      firstDate: DateTime(2015, 1),
      lastDate: DateTime(2100),
    );
    return _detailStore.selectEventDate(picked);
  }

  Future<void> _showTimePicker() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    return _detailStore.selectEventTime(picked);
  }

  Future<void> _onSave(BuildContext context) async {
    final String title = _eventTitleController.text;
    if (title == null || title.trim().isEmpty) {
      Toasts.showError(S.of(context).content_is_empty);
      return;
    }

    final DateTime eventTime = DateTime(
        _detailStore.selectedDate.year,
        _detailStore.selectedDate.month,
        _detailStore.selectedDate.day,
        _detailStore.selectedTime.hour,
        _detailStore.selectedTime.minute);
    ;
    EventStore eventStore = Provider.of<EventStore>(context);
    if (_isCreating())
      return eventStore
          .create(title, eventTime)
          .then((_) => Navigator.of(context).pop())
          .catchError((e, stack) => Toasts.showError(S.of(context).save_failed,
              error: e, stackTrace: stack));
    else
      return eventStore
          .update(_id, title, eventTime)
          .then((_) => Navigator.of(context).pop())
          .catchError((e, stack) => Toasts.showError(S.of(context).save_failed,
              error: e, stackTrace: stack));
  }
}
