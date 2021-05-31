// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "button_next": MessageLookupByLibrary.simpleMessage("Next"),
        "button_previous": MessageLookupByLibrary.simpleMessage("Previous"),
        "button_start": MessageLookupByLibrary.simpleMessage("Initialize"),
        "description_master_password": MessageLookupByLibrary.simpleMessage(
            "Master password will be the only credential for you to manage other passwords, we use it to initialize storage but it will never be stored. Once you forget the password, this is no way to find it. So please trying to set a password which is strong enough and also easy for yourself to remember."),
        "description_secondary_password": MessageLookupByLibrary.simpleMessage(
            "Secondary password is used to protect your passwords from been viewed by someone who get accessed to your unlocked app"),
        "description_start_usage": MessageLookupByLibrary.simpleMessage(
            "Almost ready... Let\'s start!"),
        "description_unlocking":
            MessageLookupByLibrary.simpleMessage("Unlocking, please wait..."),
        "helper_valid_password":
            MessageLookupByLibrary.simpleMessage("6 - 20 characters"),
        "introduction_about": MessageLookupByLibrary.simpleMessage(
            "<h5>Fully encrypted</h5><br/><p>Everything inside OKAPIA is fully encrypted with <strong>AES-256</strong> algorithm, it\'s theoretically impossible to decrypt without your master password.</p><p><a href=\"\">Learn more about security details</a></p>"),
        "label_about": MessageLookupByLibrary.simpleMessage("About"),
        "label_chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "label_get_started":
            MessageLookupByLibrary.simpleMessage("Get Started"),
        "label_license":
            MessageLookupByLibrary.simpleMessage("User Agreements"),
        "label_master_password":
            MessageLookupByLibrary.simpleMessage("Master Password"),
        "label_minder": MessageLookupByLibrary.simpleMessage("Minder"),
        "label_notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "label_okapia": MessageLookupByLibrary.simpleMessage("Okapia™"),
        "label_passwords": MessageLookupByLibrary.simpleMessage("Passwords"),
        "label_secondary_password":
            MessageLookupByLibrary.simpleMessage("Secondary Password"),
        "label_settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "label_tools": MessageLookupByLibrary.simpleMessage("Tools"),
        "tip_input_password": MessageLookupByLibrary.simpleMessage(
            "Please input your master password"),
        "tip_mandatory": MessageLookupByLibrary.simpleMessage(
            "The value could not be empty"),
        "tip_password_invalid":
            MessageLookupByLibrary.simpleMessage("Invalid password"),
        "tip_password_too_short": MessageLookupByLibrary.simpleMessage(
            "The password is not long enough")
      };
}
