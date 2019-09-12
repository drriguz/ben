abstract class KeyGenerator {
  Future<List<int>> transformKey(List<int> plantPassword, List<int> salt);
}
