import 'package:password_manager/features/passwords/data/datasources/remote_data_source.dart';
import 'package:password_manager/features/passwords/domain/entities/password_entity.dart';
import 'package:password_manager/features/passwords/domain/repositories/password_repository.dart';

class PasswordRepositoryImpl implements PasswordRepository {
  final RemoteDataSource remoteDataSource;

  PasswordRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<List<PasswordEntity>> getPasswords(String? passwordIdentifier) =>
      remoteDataSource.getPasswords(passwordIdentifier);

  @override
  void createPassword(PasswordEntity passwordEntity) =>
      remoteDataSource.createPassword(passwordEntity);

  @override
  void deletePassword(String id) {
    remoteDataSource.deletePassword(id);
  }

  @override
  void updatePassword(PasswordEntity passwordEntity) {
    remoteDataSource.updatePassword(passwordEntity);
  }
}
