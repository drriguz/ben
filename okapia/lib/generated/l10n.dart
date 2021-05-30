// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `<h5>Fully encrypted</h5><br/><p>Everything inside OKAPIA is fully encrypted with <strong>AES-256</strong> algorithm, it's theoretically impossible to decrypt without your master password.</p><p><a href="">Learn more about security details</a></p>`
  String get introduction_about {
    return Intl.message(
      '<h5>Fully encrypted</h5><br/><p>Everything inside OKAPIA is fully encrypted with <strong>AES-256</strong> algorithm, it\'s theoretically impossible to decrypt without your master password.</p><p><a href="">Learn more about security details</a></p>',
      name: 'introduction_about',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get label_about {
    return Intl.message(
      'About',
      name: 'label_about',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get label_settings {
    return Intl.message(
      'Settings',
      name: 'label_settings',
      desc: '',
      args: [],
    );
  }

  /// `User Agreements`
  String get label_license {
    return Intl.message(
      'User Agreements',
      name: 'label_license',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get label_get_started {
    return Intl.message(
      'Get Started',
      name: 'label_get_started',
      desc: '',
      args: [],
    );
  }

  /// `Master Password`
  String get label_master_password {
    return Intl.message(
      'Master Password',
      name: 'label_master_password',
      desc: '',
      args: [],
    );
  }

  /// `Secondary Password`
  String get label_secondary_password {
    return Intl.message(
      'Secondary Password',
      name: 'label_secondary_password',
      desc: '',
      args: [],
    );
  }

  /// `Master password will be the only credential for you to manage other passwords, we use it to initialize storage but it will never be stored. Once you forget the password, this is no way to find it. So please trying to set a password which is strong enough and also easy for yourself to remember.`
  String get description_master_password {
    return Intl.message(
      'Master password will be the only credential for you to manage other passwords, we use it to initialize storage but it will never be stored. Once you forget the password, this is no way to find it. So please trying to set a password which is strong enough and also easy for yourself to remember.',
      name: 'description_master_password',
      desc: '',
      args: [],
    );
  }

  /// `Secondary password is used to protect your passwords from been viewed by someone who get accessed to your unlocked app`
  String get description_secondary_password {
    return Intl.message(
      'Secondary password is used to protect your passwords from been viewed by someone who get accessed to your unlocked app',
      name: 'description_secondary_password',
      desc: '',
      args: [],
    );
  }

  /// `Almost ready... Let's start!`
  String get description_start_usage {
    return Intl.message(
      'Almost ready... Let\'s start!',
      name: 'description_start_usage',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get button_previous {
    return Intl.message(
      'Previous',
      name: 'button_previous',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get button_next {
    return Intl.message(
      'Next',
      name: 'button_next',
      desc: '',
      args: [],
    );
  }

  /// `Initialize`
  String get button_start {
    return Intl.message(
      'Initialize',
      name: 'button_start',
      desc: '',
      args: [],
    );
  }

  /// `6 - 20 characters`
  String get helper_valid_password {
    return Intl.message(
      '6 - 20 characters',
      name: 'helper_valid_password',
      desc: '',
      args: [],
    );
  }

  /// `The value could not be empty`
  String get tip_mandatory {
    return Intl.message(
      'The value could not be empty',
      name: 'tip_mandatory',
      desc: '',
      args: [],
    );
  }

  /// `The password is not long enough`
  String get tip_password_too_short {
    return Intl.message(
      'The password is not long enough',
      name: 'tip_password_too_short',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
