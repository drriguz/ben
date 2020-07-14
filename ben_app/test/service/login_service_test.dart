import 'package:ben_app/backend/shared/init_service.dart';
import 'package:ben_app/backend/shared/login_service.dart';
import 'package:ben_app/crypto/kdf.dart';
import 'package:ben_app/crypto/protected_value.dart';
import 'package:ben_app/format/data_format.dart';
import 'package:ben_app/format/storage.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockHeaderRepository extends Mock implements HeaderRepository {}

class MockKdf extends Mock implements Kdf {}

void main() async {
  final repository = new MockHeaderRepository();
  final kdf = new MockKdf();
  final loginService = LoginService(repository, kdf);

  final initService = InitializeService(repository, null, kdf);

  when(repository.saveHeaders(any)).thenAnswer((_) async => {});
  when(kdf.derive(any, any))
      .thenAnswer((invocation) async => invocation.positionalArguments[0]);
  await initService.initialize(ProtectedValue.of("correct password"), false);

  test('get user crendential', () async {
    List<Header> generatedHeaders =
        verify(repository.saveHeaders(captureAny)).captured.single;

    when(repository.getHeaders()).thenAnswer((_) async => generatedHeaders);

    expect(
        () async => await loginService
            .checkUserCredential(ProtectedValue.of("wrong password")),
        throwsA(const TypeMatcher<PasswordIncorrectError>()));
    expect(
        await loginService
            .checkUserCredential(ProtectedValue.of("correct password")),
        isNotNull);
  });
}
