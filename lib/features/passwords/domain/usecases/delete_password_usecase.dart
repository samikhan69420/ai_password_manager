import 'package:password_manager/features/passwords/domain/repositories/password_repository.dart';

class DeletePasswordUsecase {
  final PasswordRepository repository;

  DeletePasswordUsecase({required this.repository});

  void call(String id) {
    repository.deletePassword(id);
  }
}
