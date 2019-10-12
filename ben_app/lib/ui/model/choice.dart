import 'package:ben_app/plugins/option.dart';
import 'package:flutter/material.dart';

class MenuChoice extends Option<String> {
  final IconData icon;

  const MenuChoice(String option, String value, this.icon)
      : super(option, value);
}

