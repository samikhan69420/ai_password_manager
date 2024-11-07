import 'package:password_manager/features/passwords/domain/entities/password_entity.dart';
import 'package:password_manager/features/passwords/domain/repositories/password_repository.dart';

class CreatePasswordUsecase {
  final PasswordRepository repository;

  CreatePasswordUsecase({required this.repository});

  void call(PasswordEntity passwordEntity) =>
      repository.createPassword(passwordEntity);
}
