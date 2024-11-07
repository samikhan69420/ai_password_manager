import 'package:password_manager/features/ai/domain/entities/user_entity.dart';
import 'package:password_manager/features/ai/domain/repositories/ai_repository.dart';

class SetProfileUsecase {
  final AiRepository repository;
  SetProfileUsecase({required this.repository});

  void call(UserEntity userEntity) {
    return repository.setProfile(userEntity);
  }
}
