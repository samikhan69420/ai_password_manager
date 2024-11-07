import 'package:password_manager/features/ai/domain/entities/user_entity.dart';

abstract class AiRemoteDataSource {
  // Profile
  UserEntity getProfile();
  void setProfile(UserEntity userEntity);
  void updateProfile(UserEntity newProfile);
  // AI
  Future<String> getAiPassword(String prompt);
}
