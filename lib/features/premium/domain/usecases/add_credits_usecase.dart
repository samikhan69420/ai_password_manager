import 'package:password_manager/features/premium/domain/repositories/premium_repository.dart';

class AddCreditsUsecase {
  final PremiumRepository premiumRepository;
  AddCreditsUsecase({required this.premiumRepository});
  void call(double amount) => premiumRepository.addCredits(amount);
}
