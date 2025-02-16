import 'package:password_manager/features/premium/domain/repositories/premium_repository.dart';

class RemoveCreditsUsecase {
  final PremiumRepository premiumRepository;
  RemoveCreditsUsecase({required this.premiumRepository});
  void call(double amount) => premiumRepository.removeCredits(amount);
}
