abstract class Encryption {
  Future<List<int>> encrypt(final List<int> raw);

  Future<List<int>> decrypt(final List<int> raw);
}