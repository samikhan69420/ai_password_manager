import 'dart:async';
import 'dart:ui';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:password_manager/features/app/const/classes_functions/toast.dart';
import 'package:password_manager/features/premium/data/datasources/premium_remote_data_source.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PremiumRemoteDataSourceImpl implements PremiumRemoteDataSource {
  final SharedPreferences sharedPreferences;

  PremiumRemoteDataSourceImpl({required this.sharedPreferences});

  @override
  void addCredits(double amount) async {
    double credits = sharedPreferences.getDouble('credits') ?? 0;
    credits += amount;
    await sharedPreferences.setDouble('credits', credits);
  }

  @override
  double getCredits() {
    return sharedPreferences.getDouble('credits') ?? 0;
  }

  @override
  void removeCredits(double amount) async {
    double credits = sharedPreferences.getDouble('credits') ?? 0;
    credits -= amount;
    await sharedPreferences.setDouble('credits', credits);
  }

  @override
  Future<void> showVideoAd(BuildContext context,
      {required VoidCallback onAdFinished}) async {
    final adUnit = "ca-app-pub-3880477927165897/8301084899";
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(color: Colors.black.withAlpha(60)),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: SizedBox.expand(),
            ),
            Card(
              child: Basic(
                leadingAlignment: Alignment.center,
                title: Text("Loading...").h4(),
                leading: CircularProgressIndicator(
                  size: 20,
                ),
              ),
            )
                .animate()
                .moveY(curve: Curves.easeOutCirc)
                .scale(
                    curve: Curves.easeOutCirc,
                    duration: 700.ms,
                    begin: Offset(0.9, 0.9))
                .fadeIn()
                .blur(begin: Offset(5, 5), end: Offset.zero),
          ],
        ),
      ),
    );
    await RewardedAd.load(
        adUnitId: adUnit,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) async {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                Navigator.pop(context);
              },
            );
            await ad.show(
              onUserEarnedReward: (ad, reward) async {
                onAdFinished();
              },
            );
          },
          onAdFailedToLoad: (error) {
            Navigator.pop(context);
            showToastification(error.message);
          },
        ));
  }
}
