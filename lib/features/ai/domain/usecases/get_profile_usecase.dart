import 'package:password_manager/features/ai/domain/entities/user_entity.dart';
import 'package:password_manager/features/ai/domain/repositories/ai_repository.dart';

class GetProfileUsecase {
  final AiRepository repository;

  GetProfileUsecase({required this.repository});

  UserEntity call() => repository.getProfile();
}
