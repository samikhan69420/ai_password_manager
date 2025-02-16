import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:password_manager/features/premium/domain/usecases/add_credits_usecase.dart';
import 'package:password_manager/features/premium/domain/usecases/get_credits_usecase.dart';
import 'package:password_manager/features/premium/domain/usecases/remove_credits_usecase.dart';
import 'package:password_manager/features/premium/domain/usecases/show_video_ad_usecase.dart';
import 'package:password_manager/features/premium/presentation/widgets/insufficient_credits.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

part 'premium_cubit_state.dart';

class PremiumCubit extends Cubit<PremiumCubitState> {
  final GetCreditsUsecase getCreditsUsecase;
  final AddCreditsUsecase addCreditsUsecase;
  final RemoveCreditsUsecase removeCreditsUsecase;
  final ShowVideoAdUsecase showVideoAdUsecase;
  PremiumCubit({
    required this.showVideoAdUsecase,
    required this.addCreditsUsecase,
    required this.removeCreditsUsecase,
    required this.getCreditsUsecase,
  }) : super(PremiumCubitInitial());

  void showVideoAd(BuildContext context) async {
    emit(PremiumCubitLoading());
    try {
      await showVideoAdUsecase.call(
        context,
        onAdFinished: () {
          addCreditsUsecase.call(10);
          final credits = getCreditsUsecase.call();
          emit(PremiumCubitLoaded(credits: credits));
        },
      );
    } catch (e) {
      emit(PremiumCubitFailure());
    }
  }

  double getCreditsCount() {
    return getCreditsUsecase.call();
  }

  void getCredits() {
    emit(PremiumCubitLoading());
    try {
      final credits = getCreditsUsecase.call();
      emit(PremiumCubitLoaded(credits: credits));
    } catch (e) {
      emit(PremiumCubitFailure());
    }
  }

  Future<void> removeCredits(double amount, BuildContext context) async {
    final credits = getCreditsUsecase.call();
    if (credits <= 0) {
      showCreditsDialog(context);
    } else {
      removeCreditsUsecase.call(amount);
    }
  }
}
