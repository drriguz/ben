import 'package:flutter/material.dart';

class Option<T> {
  const Option(this.displayName, this.value);

  final String displayName;
  final T value;
}

class MenuChoice extends Option<String> {
  final IconData icon;

  const MenuChoice(String option, String value, this.icon)
      : super(option, value);
}

