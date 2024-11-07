import 'package:password_manager/features/passwords/domain/entities/password_entity.dart';

abstract class PasswordRepository {
  void createPassword(PasswordEntity passwordEntity);
  void deletePassword(String id);
  void updatePassword(PasswordEntity passwordEntity);
  Stream<List<PasswordEntity>> getPasswords(String? passwordIdentifier);
}
