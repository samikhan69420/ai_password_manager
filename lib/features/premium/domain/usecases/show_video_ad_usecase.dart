import 'package:password_manager/features/premium/domain/repositories/premium_repository.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ShowVideoAdUsecase {
  final PremiumRepository premiumRepository;
  ShowVideoAdUsecase({required this.premiumRepository});

  Future<void> call(BuildContext context,
          {required VoidCallback onAdFinished}) async =>
      await premiumRepository.showVideoAd(context, onAdFinished: onAdFinished);
}
