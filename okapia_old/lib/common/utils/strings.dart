class Strings {
  static String masking(String number) {
    String masked = "****";
    if (number != null && number.length > 4)
      masked += " " + number.substring(number.length - 4);
    return masked;
  }

  static final RegExp URL_REGEX = new RegExp(
      r'^https?://(www\.)?[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_+.~#?&//=]*)$',
      caseSensitive: false);

  static bool isValidUrl(String url) {
    return URL_REGEX.hasMatch(url);
  }
}
