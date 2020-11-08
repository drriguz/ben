import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PathUtil {
  static Future<String> getLocalPath(String relativePath) async {
    final directory = await getApplicationDocumentsDirectory();
    return join(directory.path, relativePath);
  }
}
