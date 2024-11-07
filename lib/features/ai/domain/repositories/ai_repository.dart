import 'package:password_manager/features/ai/domain/entities/user_entity.dart';

abstract class AiRepository {
  // Profile
  UserEntity getProfile();
  void setProfile(UserEntity user);
  void updateProfile(UserEntity newProfile);
  // AI
  Future<String> getAiPassword(String prompt);
}
