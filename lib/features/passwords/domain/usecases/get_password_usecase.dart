import 'package:password_manager/features/passwords/domain/entities/password_entity.dart';
import 'package:password_manager/features/passwords/domain/repositories/password_repository.dart';

class GetPasswordUsecase {
  final PasswordRepository repository;

  GetPasswordUsecase({required this.repository});

  Stream<List<PasswordEntity>> call(String? passwordIdentifier) =>
      repository.getPasswords(passwordIdentifier);
}
