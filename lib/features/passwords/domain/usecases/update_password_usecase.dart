import 'package:password_manager/features/passwords/domain/entities/password_entity.dart';
import 'package:password_manager/features/passwords/domain/repositories/password_repository.dart';

class UpdatePasswordUsecase {
  final PasswordRepository repository;

  UpdatePasswordUsecase({required this.repository});

  void call(PasswordEntity passwordEntity) {
    repository.updatePassword(passwordEntity);
  }
}
