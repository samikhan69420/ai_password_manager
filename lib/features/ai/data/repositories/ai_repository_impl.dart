import 'package:password_manager/features/ai/data/datasources/ai_remote_data_source.dart';
import 'package:password_manager/features/ai/domain/entities/user_entity.dart';
import 'package:password_manager/features/ai/domain/repositories/ai_repository.dart';

class AiRepositoryImpl implements AiRepository {
  final AiRemoteDataSource remoteDataSource;

  AiRepositoryImpl({required this.remoteDataSource});

  @override
  UserEntity getProfile() => remoteDataSource.getProfile();

  @override
  void setProfile(UserEntity user) => remoteDataSource.setProfile(user);

  @override
  void updateProfile(UserEntity newProfile) =>
      remoteDataSource.updateProfile(newProfile);

  @override
  Future<String> getAiPassword(String prompt) =>
      remoteDataSource.getAiPassword(prompt);
}
