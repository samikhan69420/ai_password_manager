import 'package:password_manager/features/ai/domain/repositories/ai_repository.dart';

class GetAiPasswordUsecase {
  final AiRepository repository;

  GetAiPasswordUsecase({required this.repository});
  Future<String> call(String prompt) => repository.getAiPassword(prompt);
}
