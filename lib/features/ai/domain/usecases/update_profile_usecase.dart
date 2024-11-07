import 'package:password_manager/features/ai/domain/entities/user_entity.dart';
import 'package:password_manager/features/ai/domain/repositories/ai_repository.dart';

class UpdateProfileUsecase {
  final AiRepository repository;

  UpdateProfileUsecase({required this.repository});

  void call(UserEntity newProfile) => repository.updateProfile(newProfile);
}
