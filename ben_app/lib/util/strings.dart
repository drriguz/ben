class Strings {
  static String masking(String number) {
    String masked = "****";
    if (number != null && number.length > 4)
      masked += " " + number.substring(number.length - 4);
    return masked;
  }
}
