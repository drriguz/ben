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
// ignore_for_file: avoid_redundant_argument_values

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
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
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

  /// `Previous`
  String get previous {
    return Intl.message(
      'Previous',
      name: 'previous',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `<h5>Fully encrypted</h5><br/><p>Everything inside OKAPIA is fully encrypted with <strong>AES-256</strong> algorithm, it's theoretically impossible to decrypt without your master password.</p><p><a href="">Learn more about security details</a></p>`
  String get security_description {
    return Intl.message(
      '<h5>Fully encrypted</h5><br/><p>Everything inside OKAPIA is fully encrypted with <strong>AES-256</strong> algorithm, it\'s theoretically impossible to decrypt without your master password.</p><p><a href="">Learn more about security details</a></p>',
      name: 'security_description',
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

  /// `Secondary password is used to protect your passwords from been viewed by someone who get accessed to your unlocked app`
  String get secondary_password_description {
    return Intl.message(
      'Secondary password is used to protect your passwords from been viewed by someone who get accessed to your unlocked app',
      name: 'secondary_password_description',
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

  /// `Enable fingerprint so that you can unlock with your fingerprint(if supported), however master password is required whenever the first time you login into Okapia.`
  String get enable_fingerprint_description {
    return Intl.message(
      'Enable fingerprint so that you can unlock with your fingerprint(if supported), however master password is required whenever the first time you login into Okapia.',
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

  /// `Master password`
  String get master_password {
    return Intl.message(
      'Master password',
      name: 'master_password',
      desc: '',
      args: [],
    );
  }

  /// `at least 10 characters`
  String get master_password_hint {
    return Intl.message(
      'at least 10 characters',
      name: 'master_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm master password`
  String get confirm_master_password {
    return Intl.message(
      'Confirm master password',
      name: 'confirm_master_password',
      desc: '',
      args: [],
    );
  }

  /// `Master password`
  String get secondary_password {
    return Intl.message(
      'Master password',
      name: 'secondary_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm secondary password`
  String get confirm_secondary_password {
    return Intl.message(
      'Confirm secondary password',
      name: 'confirm_secondary_password',
      desc: '',
      args: [],
    );
  }

  /// `4 digits`
  String get secondary_password_hint {
    return Intl.message(
      '4 digits',
      name: 'secondary_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Secondary password must be 4 digits`
  String get secondary_password_rule {
    return Intl.message(
      'Secondary password must be 4 digits',
      name: 'secondary_password_rule',
      desc: '',
      args: [],
    );
  }

  /// `Confirm secondary password`
  String get secondary_master_password {
    return Intl.message(
      'Confirm secondary password',
      name: 'secondary_master_password',
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

  /// `Please input your password`
  String get please_input_master_password {
    return Intl.message(
      'Please input your password',
      name: 'please_input_master_password',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get password_validation_failed {
    return Intl.message(
      'Incorrect password',
      name: 'password_validation_failed',
      desc: '',
      args: [],
    );
  }

  /// `Unlocking, please wait...`
  String get unlocking {
    return Intl.message(
      'Unlocking, please wait...',
      name: 'unlocking',
      desc: '',
      args: [],
    );
  }

  /// `Secret`
  String get secret {
    return Intl.message(
      'Secret',
      name: 'secret',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get reminder {
    return Intl.message(
      'Reminder',
      name: 'reminder',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get photo {
    return Intl.message(
      'Photo',
      name: 'photo',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Toolbox`
  String get toolbox {
    return Intl.message(
      'Toolbox',
      name: 'toolbox',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get event {
    return Intl.message(
      'Events',
      name: 'event',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get note {
    return Intl.message(
      'Notes',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Strongbox`
  String get strongbox {
    return Intl.message(
      'Strongbox',
      name: 'strongbox',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Card`
  String get card {
    return Intl.message(
      'Card',
      name: 'card',
      desc: '',
      args: [],
    );
  }

  /// `Content is empty`
  String get content_is_empty {
    return Intl.message(
      'Content is empty',
      name: 'content_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `Save failed, reason:`
  String get save_failed {
    return Intl.message(
      'Save failed, reason:',
      name: 'save_failed',
      desc: '',
      args: [],
    );
  }

  /// `Create new event`
  String get creating_event {
    return Intl.message(
      'Create new event',
      name: 'creating_event',
      desc: '',
      args: [],
    );
  }

  /// `Edit event`
  String get editing_event {
    return Intl.message(
      'Edit event',
      name: 'editing_event',
      desc: '',
      args: [],
    );
  }

  /// `Please choose event time`
  String get please_choose_time {
    return Intl.message(
      'Please choose event time',
      name: 'please_choose_time',
      desc: '',
      args: [],
    );
  }

  /// `Please input event title`
  String get please_input_title {
    return Intl.message(
      'Please input event title',
      name: 'please_input_title',
      desc: '',
      args: [],
    );
  }

  /// `Create checklist`
  String get create_checklist {
    return Intl.message(
      'Create checklist',
      name: 'create_checklist',
      desc: '',
      args: [],
    );
  }

  /// `Take photo`
  String get add_photo {
    return Intl.message(
      'Take photo',
      name: 'add_photo',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete?`
  String get confirm_delete {
    return Intl.message(
      'Are you sure to delete?',
      name: 'confirm_delete',
      desc: '',
      args: [],
    );
  }

  /// `Create album`
  String get creating_album {
    return Intl.message(
      'Create album',
      name: 'creating_album',
      desc: '',
      args: [],
    );
  }

  /// `Edit album`
  String get editing_album {
    return Intl.message(
      'Edit album',
      name: 'editing_album',
      desc: '',
      args: [],
    );
  }

  /// `Album`
  String get album {
    return Intl.message(
      'Album',
      name: 'album',
      desc: '',
      args: [],
    );
  }

  /// `Album name`
  String get album_name {
    return Intl.message(
      'Album name',
      name: 'album_name',
      desc: '',
      args: [],
    );
  }

  /// `View album`
  String get view_album {
    return Intl.message(
      'View album',
      name: 'view_album',
      desc: '',
      args: [],
    );
  }

  /// `The albums is protected and it's not visible out of Okapia`
  String get album_description {
    return Intl.message(
      'The albums is protected and it\'s not visible out of Okapia',
      name: 'album_description',
      desc: '',
      args: [],
    );
  }

  /// `Add password`
  String get create_password {
    return Intl.message(
      'Add password',
      name: 'create_password',
      desc: '',
      args: [],
    );
  }

  /// `The following fields are double encrypted, you'll need to input PIN to view those fields`
  String get public_fields {
    return Intl.message(
      'The following fields are double encrypted, you\'ll need to input PIN to view those fields',
      name: 'public_fields',
      desc: '',
      args: [],
    );
  }

  /// `Saving...`
  String get saving {
    return Intl.message(
      'Saving...',
      name: 'saving',
      desc: '',
      args: [],
    );
  }

  /// `Failed to download the icon`
  String get download_icon_failed {
    return Intl.message(
      'Failed to download the icon',
      name: 'download_icon_failed',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Login url`
  String get login_url {
    return Intl.message(
      'Login url',
      name: 'login_url',
      desc: '',
      args: [],
    );
  }

  /// `Name of the password`
  String get password_name_hint {
    return Intl.message(
      'Name of the password',
      name: 'password_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Additional account info for this password`
  String get password_account_hint {
    return Intl.message(
      'Additional account info for this password',
      name: 'password_account_hint',
      desc: '',
      args: [],
    );
  }

  /// `The login url for this account`
  String get password_url_hint {
    return Intl.message(
      'The login url for this account',
      name: 'password_url_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match with the previous one`
  String get password_not_match {
    return Intl.message(
      'Password does not match with the previous one',
      name: 'password_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Please enter some text`
  String get please_input_the_value {
    return Intl.message(
      'Please enter some text',
      name: 'please_input_the_value',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get password_confirm {
    return Intl.message(
      'Confirm password',
      name: 'password_confirm',
      desc: '',
      args: [],
    );
  }

  /// `View password detail`
  String get view_password_detail {
    return Intl.message(
      'View password detail',
      name: 'view_password_detail',
      desc: '',
      args: [],
    );
  }

  /// `Invalid url address`
  String get invalid_url {
    return Intl.message(
      'Invalid url address',
      name: 'invalid_url',
      desc: '',
      args: [],
    );
  }

  /// `(N/A)`
  String get not_available {
    return Intl.message(
      '(N/A)',
      name: 'not_available',
      desc: '',
      args: [],
    );
  }

  /// `Decrypt password detail`
  String get show_password {
    return Intl.message(
      'Decrypt password detail',
      name: 'show_password',
      desc: '',
      args: [],
    );
  }

  /// `Please input your secondary password`
  String get please_input_secondary_password {
    return Intl.message(
      'Please input your secondary password',
      name: 'please_input_secondary_password',
      desc: '',
      args: [],
    );
  }

  /// `Re-input the password you want to save. This is not your master password!`
  String get password_confirm_tip {
    return Intl.message(
      'Re-input the password you want to save. This is not your master password!',
      name: 'password_confirm_tip',
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