import "package:password_manager/features/premium/data/datasources/premium_remote_data_source.dart";
import "package:password_manager/features/premium/data/datasources/premium_remote_data_source_impl.dart";
import "package:password_manager/features/premium/data/repositories/premium_repository_impl.dart";
import "package:password_manager/features/premium/domain/repositories/premium_repository.dart";
import "package:password_manager/features/premium/domain/usecases/add_credits_usecase.dart";
import "package:password_manager/features/premium/domain/usecases/get_credits_usecase.dart";
import "package:password_manager/features/premium/domain/usecases/remove_credits_usecase.dart";
import "package:password_manager/features/premium/domain/usecases/show_video_ad_usecase.dart";
import "package:password_manager/features/premium/presentation/cubit/premium_cubit_cubit.dart";
import "package:password_manager/main_injection_container.dart";

Future<void> premiumInjectionContainer() async {
  // Cubit

  sl.registerFactory<PremiumCubit>(
    () => PremiumCubit(
      showVideoAdUsecase: sl.call(),
      addCreditsUsecase: sl.call(),
      removeCreditsUsecase: sl.call(),
      getCreditsUsecase: sl.call(),
    ),
  );

  // Usecases

  sl.registerLazySingleton<AddCreditsUsecase>(
    () => AddCreditsUsecase(premiumRepository: sl.call()),
  );
  sl.registerLazySingleton<RemoveCreditsUsecase>(
    () => RemoveCreditsUsecase(premiumRepository: sl.call()),
  );
  sl.registerLazySingleton<GetCreditsUsecase>(
    () => GetCreditsUsecase(premiumRepository: sl.call()),
  );
  sl.registerLazySingleton<ShowVideoAdUsecase>(
    () => ShowVideoAdUsecase(premiumRepository: sl.call()),
  );

  // Repositories

  sl.registerLazySingleton<PremiumRepository>(
    () => PremiumRepositoryImpl(
      remoteDataSource: sl.call(),
    ),
  );
  sl.registerLazySingleton<PremiumRemoteDataSource>(
    () => PremiumRemoteDataSourceImpl(
      sharedPreferences: sl.call(),
    ),
  );
}
