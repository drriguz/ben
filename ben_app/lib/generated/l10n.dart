// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `About`
  String get about_okapia {
    return Intl.message(
      'About',
      name: 'about_okapia',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get system_settings {
    return Intl.message(
      'Settings',
      name: 'system_settings',
      desc: '',
      args: [],
    );
  }

  /// `User Agreement`
  String get user_agreement {
    return Intl.message(
      'User Agreement',
      name: 'user_agreement',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get get_started {
    return Intl.message(
      'Get Started',
      name: 'get_started',
      desc: '',
      args: [],
    );
  }

  /// `Previous Step`
  String get previous {
    return Intl.message(
      'Previous Step',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Next Step`
  String get next {
    return Intl.message(
      'Next Step',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Okapia helps you to store all your password in one place.`
  String get about_description_1 {
    return Intl.message(
      'Okapia helps you to store all your password in one place.',
      name: 'about_description_1',
      desc: '',
      args: [],
    );
  }

  /// `Your passwords will be encrypted using AES-256, and then stored in a local file. Your password will be safe even if the file is exposed, only if someone knows the master password can decrypt it.`
  String get about_description_2 {
    return Intl.message(
      'Your passwords will be encrypted using AES-256, and then stored in a local file. Your password will be safe even if the file is exposed, only if someone knows the master password can decrypt it.',
      name: 'about_description_2',
      desc: '',
      args: [],
    );
  }

  /// `Although Okapia is the one you can trust, we still do not encourage you to rely too much on it, it's always the best to keep everything in mind, only use it when it's really necessary.`
  String get about_description_3 {
    return Intl.message(
      'Although Okapia is the one you can trust, we still do not encourage you to rely too much on it, it\'s always the best to keep everything in mind, only use it when it\'s really necessary.',
      name: 'about_description_3',
      desc: '',
      args: [],
    );
  }

  /// `Learn more about security details`
  String get know_more_security_details {
    return Intl.message(
      'Learn more about security details',
      name: 'know_more_security_details',
      desc: '',
      args: [],
    );
  }

  /// `Master password will be the only credential for you to manage other passwords, we use it to initialize storage but it will never be stored. Once you forget the password, this is no way to find it. So please trying to set a password which is strong enough and also easy for yourself to remember. `
  String get master_password_description {
    return Intl.message(
      'Master password will be the only credential for you to manage other passwords, we use it to initialize storage but it will never be stored. Once you forget the password, this is no way to find it. So please trying to set a password which is strong enough and also easy for yourself to remember. ',
      name: 'master_password_description',
      desc: '',
      args: [],
    );
  }

  /// `Enable fingerprint`
  String get enable_fingerprint {
    return Intl.message(
      'Enable fingerprint',
      name: 'enable_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `您可以开启指纹验证，这样仅需要在启动应用时输入一次主密码。当您重启应用之后，需要重新输入主密码。`
  String get enable_fingerprint_description {
    return Intl.message(
      '您可以开启指纹验证，这样仅需要在启动应用时输入一次主密码。当您重启应用之后，需要重新输入主密码。',
      name: 'enable_fingerprint_description',
      desc: '',
      args: [],
    );
  }

  /// `Auto detect encrypt options`
  String get enable_password_options_auto_detect {
    return Intl.message(
      'Auto detect encrypt options',
      name: 'enable_password_options_auto_detect',
      desc: '',
      args: [],
    );
  }

  /// `开启后，系统会尝试根据您的设备计算出（比默认更强的）达到要求的安全设置。如果不开启系统将会使用推荐的默认设置。`
  String get enable_password_options_auto_detect_description {
    return Intl.message(
      '开启后，系统会尝试根据您的设备计算出（比默认更强的）达到要求的安全设置。如果不开启系统将会使用推荐的默认设置。',
      name: 'enable_password_options_auto_detect_description',
      desc: '',
      args: [],
    );
  }

  /// `Please input your password`
  String get please_input_password {
    return Intl.message(
      'Please input your password',
      name: 'please_input_password',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get please_input_password_again {
    return Intl.message(
      'Please confirm your password',
      name: 'please_input_password_again',
      desc: '',
      args: [],
    );
  }

  /// `Password is too short`
  String get password_too_short {
    return Intl.message(
      'Password is too short',
      name: 'password_too_short',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get password_does_not_match {
    return Intl.message(
      'Password does not match',
      name: 'password_does_not_match',
      desc: '',
      args: [],
    );
  }

  /// `I Agree`
  String get agree {
    return Intl.message(
      'I Agree',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `<h2>End-User License Agreement (EULA) of <span class="app_name">Okapia</span></h2>\n\n<p>This End-User License Agreement ("EULA") is a legal agreement between you and <span class="company_name">Riguz.com</span></p>\n\n<p>This EULA agreement governs your acquisition and use of our <span class="app_name">Okapia</span> software ("Software") directly from <span class="company_name">Riguz.com</span> or indirectly through a <span class="company_name">Riguz.com</span> authorized reseller or distributor (a "Reseller").</p>\n\n<p>Please read this EULA agreement carefully before completing the installation process and using the <span class="app_name">Okapia</span> software. It provides a license to use the <span class="app_name">Okapia</span> software and contains warranty information and liability disclaimers.</p>\n\n<p>If you register for a free trial of the <span class="app_name">Okapia</span> software, this EULA agreement will also govern that trial. By clicking "accept" or installing and/or using the <span class="app_name">Okapia</span> software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement.</p>\n\n<p>If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.</p>\n\n<p>This EULA agreement shall apply only to the Software supplied by <span class="company_name">Riguz.com</span> herewith regardless of whether other software is referred to or described herein. The terms also apply to any <span class="company_name">Riguz.com</span> updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply. This EULA was created by <a href="https://www.eulatemplate.com">EULA Template</a> for <span class="app_name">Okapia</span>.\n\n<h3>License Grant</h3>\n\n<p><span class="company_name">Riguz.com</span> hereby grants you a personal, non-transferable, non-exclusive licence to use the <span class="app_name">Okapia</span> software on your devices in accordance with the terms of this EULA agreement.</p>\n\n<p>You are permitted to load the <span class="app_name">Okapia</span> software (for example a PC, laptop, mobile or tablet) under your control. You are responsible for ensuring your device meets the minimum requirements of the <span class="app_name">Okapia</span> software.</p>\n\n<p>You are not permitted to:</p>\n\n<ul>\n<li>Edit, alter, modify, adapt, translate or otherwise change the whole or any part of the Software nor permit the whole or any part of the Software to be combined with or become incorporated in any other software, nor decompile, disassemble or reverse engineer the Software or attempt to do any such things</li>\n<li>Reproduce, copy, distribute, resell or otherwise use the Software for any commercial purpose</li>\n<li>Allow any third party to use the Software on behalf of or for the benefit of any third party</li>\n<li>Use the Software in any way which breaches any applicable local, national or international law</li>\n<li>use the Software for any purpose that <span class="company_name">Riguz.com</span> considers is a breach of this EULA agreement</li>\n</ul>\n\n<h3>Intellectual Property and Ownership</h3>\n\n<p><span class="company_name">Riguz.com</span> shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of <span class="company_name">Riguz.com</span>.</p>\n\n<p><span class="company_name">Riguz.com</span> reserves the right to grant licences to use the Software to third parties.</p>\n\n<h3>Termination</h3>\n\n<p>This EULA agreement is effective from the date you first use the Software and shall continue until terminated. You may terminate it at any time upon written notice to <span class="company_name">Riguz.com</span>.</p>\n\n<p>It will also terminate immediately if you fail to comply with any term of this EULA agreement. Upon such termination, the licenses granted by this EULA agreement will immediately terminate and you agree to stop all access and use of the Software. The provisions that by their nature continue and survive will survive any termination of this EULA agreement.</p>\n\n<h3>Governing Law</h3>\n\n<p>This EULA agreement, and any dispute arising out of or in connection with this EULA agreement, shall be governed by and construed in accordance with the laws of <span class="country">cn</span>.</p>`
  String get user_agreement_detail {
    return Intl.message(
      '<h2>End-User License Agreement (EULA) of <span class="app_name">Okapia</span></h2>\n\n<p>This End-User License Agreement ("EULA") is a legal agreement between you and <span class="company_name">Riguz.com</span></p>\n\n<p>This EULA agreement governs your acquisition and use of our <span class="app_name">Okapia</span> software ("Software") directly from <span class="company_name">Riguz.com</span> or indirectly through a <span class="company_name">Riguz.com</span> authorized reseller or distributor (a "Reseller").</p>\n\n<p>Please read this EULA agreement carefully before completing the installation process and using the <span class="app_name">Okapia</span> software. It provides a license to use the <span class="app_name">Okapia</span> software and contains warranty information and liability disclaimers.</p>\n\n<p>If you register for a free trial of the <span class="app_name">Okapia</span> software, this EULA agreement will also govern that trial. By clicking "accept" or installing and/or using the <span class="app_name">Okapia</span> software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement.</p>\n\n<p>If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.</p>\n\n<p>This EULA agreement shall apply only to the Software supplied by <span class="company_name">Riguz.com</span> herewith regardless of whether other software is referred to or described herein. The terms also apply to any <span class="company_name">Riguz.com</span> updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply. This EULA was created by <a href="https://www.eulatemplate.com">EULA Template</a> for <span class="app_name">Okapia</span>.\n\n<h3>License Grant</h3>\n\n<p><span class="company_name">Riguz.com</span> hereby grants you a personal, non-transferable, non-exclusive licence to use the <span class="app_name">Okapia</span> software on your devices in accordance with the terms of this EULA agreement.</p>\n\n<p>You are permitted to load the <span class="app_name">Okapia</span> software (for example a PC, laptop, mobile or tablet) under your control. You are responsible for ensuring your device meets the minimum requirements of the <span class="app_name">Okapia</span> software.</p>\n\n<p>You are not permitted to:</p>\n\n<ul>\n<li>Edit, alter, modify, adapt, translate or otherwise change the whole or any part of the Software nor permit the whole or any part of the Software to be combined with or become incorporated in any other software, nor decompile, disassemble or reverse engineer the Software or attempt to do any such things</li>\n<li>Reproduce, copy, distribute, resell or otherwise use the Software for any commercial purpose</li>\n<li>Allow any third party to use the Software on behalf of or for the benefit of any third party</li>\n<li>Use the Software in any way which breaches any applicable local, national or international law</li>\n<li>use the Software for any purpose that <span class="company_name">Riguz.com</span> considers is a breach of this EULA agreement</li>\n</ul>\n\n<h3>Intellectual Property and Ownership</h3>\n\n<p><span class="company_name">Riguz.com</span> shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of <span class="company_name">Riguz.com</span>.</p>\n\n<p><span class="company_name">Riguz.com</span> reserves the right to grant licences to use the Software to third parties.</p>\n\n<h3>Termination</h3>\n\n<p>This EULA agreement is effective from the date you first use the Software and shall continue until terminated. You may terminate it at any time upon written notice to <span class="company_name">Riguz.com</span>.</p>\n\n<p>It will also terminate immediately if you fail to comply with any term of this EULA agreement. Upon such termination, the licenses granted by this EULA agreement will immediately terminate and you agree to stop all access and use of the Software. The provisions that by their nature continue and survive will survive any termination of this EULA agreement.</p>\n\n<h3>Governing Law</h3>\n\n<p>This EULA agreement, and any dispute arising out of or in connection with this EULA agreement, shall be governed by and construed in accordance with the laws of <span class="country">cn</span>.</p>',
      name: 'user_agreement_detail',
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
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}