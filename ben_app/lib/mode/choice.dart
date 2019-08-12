import 'package:flutter/material.dart';

class Option<T> {
  const Option(this.option, this.value);

  final String option;
  final T value;
}

class MenuChoice extends Option<String> {
  final IconData icon;

  const MenuChoice(String option, String value, this.icon)
      : super(option, value);
}

enum SecretListType {
  CARD,
  CERTIFICATE,
  MEDIA,
  PASSWORD,
  NOTE,
  FILE,
}

class TabChoice extends Option<SecretListType> {
  const TabChoice(String option, SecretListType value) : super(option, value);
}
