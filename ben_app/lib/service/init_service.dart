import 'package:ben_app/format/storage.dart';

class InitService {
  final HeaderRepository headerRepository;

  InitService(this.headerRepository);

  Future<void> checkHeader() async {
    await headerRepository.getHeaders();
    print('hello');
  }
}
