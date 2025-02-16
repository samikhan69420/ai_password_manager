import 'package:password_manager/features/premium/domain/repositories/premium_repository.dart';

class GetCreditsUsecase {
  final PremiumRepository premiumRepository;
  GetCreditsUsecase({required this.premiumRepository});

  double call() => premiumRepository.getCredits();
}
