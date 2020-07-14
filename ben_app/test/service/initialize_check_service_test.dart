import 'package:ben_app/backend/common/services/init_check_service.dart';
import 'package:ben_app/backend/common/format/sqlite/header_entity.dart';
import 'package:ben_app/backend/common/format/storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockHeaderRepository extends Mock implements HeaderRepository {}

void main() {
  final repository = new MockHeaderRepository();
  final service = InitializeCheckService(repository);

  test('not initialized', () async {
    when(repository.getHeaders()).thenAnswer((_) async => []);
    expect(await service.hasInitialized(), false);
  });

  test('already initialized', () async {
    when(repository.getHeaders()).thenAnswer((_) async => [HeaderEntity()]);
    expect(await service.hasInitialized(), true);
  });
}
