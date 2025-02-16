import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class PremiumRemoteDataSource {
  double getCredits();
  void addCredits(double amount);
  void removeCredits(double amount);
  Future<void> showVideoAd(BuildContext context,
      {required VoidCallback onAdFinished});
}
