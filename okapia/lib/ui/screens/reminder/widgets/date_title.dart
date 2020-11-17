import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:okapia/ui/theme/styles.dart';

class DateTitle extends StatelessWidget {
  final DateTime _dateTime;

  static final timeFormat = new DateFormat.jm();
  static final dayOfWeekFormat = new DateFormat("EEEE");
  static final monthFormat = new DateFormat("MMM");

  const DateTitle(this._dateTime, {Key key}) : super(key: key);

  Widget _title() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            _dateTime.day.toString(),
            style: const TextStyle(
              color: Colors.indigo,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            monthFormat.format(_dateTime),
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black45,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            "${_dateTime.year.toString()}, ${dayOfWeekFormat.format(_dateTime)}",
            style: Styles.descriptionStyle,
          ),
        ),
      ],
    );
  }

  Widget _subtitle() {
    return Row(
      children: [
        Text(
          timeFormat.format(_dateTime),
          style: const TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _title(),
        _subtitle(),
      ],
    );
  }
}
