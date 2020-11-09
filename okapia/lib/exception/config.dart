class InvalidConfigFormatException implements Exception {
  final String cause;

  InvalidConfigFormatException(this.cause);

  @override
  String toString() {
    return cause;
  }
}

class InvalidConfigDataException implements Exception {
  final String cause;

  InvalidConfigDataException(this.cause);

  @override
  String toString() {
    return cause;
  }
}
