import '../mode/meta_data.dart';

abstract class HashValidator {
  List<int> computeChecksum(AppMetaData meta, List<String> dataIds);
}
