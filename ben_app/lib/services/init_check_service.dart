import '../common/sqlite/repository/header_repository.dart';

class InitializeCheckService {
  final HeaderRepository _headerRepository;

  InitializeCheckService(this._headerRepository);

  Future<bool> hasInitialized() async {
    final headers = await _headerRepository.getHeaders();
    return headers.isNotEmpty;
  }
}
