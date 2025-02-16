import 'package:password_manager/features/premium/data/datasources/premium_remote_data_source.dart';
import 'package:password_manager/features/premium/domain/repositories/premium_repository.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PremiumRepositoryImpl implements PremiumRepository {
  final PremiumRemoteDataSource remoteDataSource;

  PremiumRepositoryImpl({required this.remoteDataSource});
  @override
  void addCredits(double amount) => remoteDataSource.addCredits(amount);

  @override
  double getCredits() => remoteDataSource.getCredits();

  @override
  void removeCredits(double amount) => remoteDataSource.removeCredits(amount);

  @override
  Future<void> showVideoAd(BuildContext context,
          {required VoidCallback onAdFinished}) =>
      remoteDataSource.showVideoAd(context, onAdFinished: onAdFinished);
}
