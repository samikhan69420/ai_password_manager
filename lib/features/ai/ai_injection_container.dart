import 'package:password_manager/features/ai/data/datasources/ai_remote_data_source.dart';
import 'package:password_manager/features/ai/data/datasources/ai_remote_data_source_impl.dart';
import 'package:password_manager/features/ai/data/repositories/ai_repository_impl.dart';
import 'package:password_manager/features/ai/domain/repositories/ai_repository.dart';
import 'package:password_manager/features/ai/domain/usecases/get_password_usecase.dart';
import 'package:password_manager/features/ai/domain/usecases/get_profile_usecase.dart';
import 'package:password_manager/features/ai/domain/usecases/set_profile_usecase.dart';
import 'package:password_manager/features/ai/domain/usecases/update_profile_usecase.dart';
import 'package:password_manager/features/ai/presentation/cubit/ai_cubit/ai_cubit.dart';
import 'package:password_manager/features/ai/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:password_manager/main_injection_container.dart';

Future<void> aiInjectionContainer() async {
  // Cubit

  sl.registerFactory<AiCubit>(() => AiCubit(
        getAiPasswordUsecase: sl.call(),
      ));

  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      getProfileUsecase: sl.call(),
      updateProfileUsecase: sl.call(),
      setProfileUsecase: sl.call(),
    ),
  );

  // Usecases

  sl.registerLazySingleton<SetProfileUsecase>(
    () => SetProfileUsecase(
      repository: sl.call(),
    ),
  );
  sl.registerLazySingleton<UpdateProfileUsecase>(
    () => UpdateProfileUsecase(
      repository: sl.call(),
    ),
  );
  sl.registerLazySingleton<GetProfileUsecase>(
    () => GetProfileUsecase(
      repository: sl.call(),
    ),
  );
  sl.registerLazySingleton<GetAiPasswordUsecase>(
    () => GetAiPasswordUsecase(
      repository: sl.call(),
    ),
  );

  // Repositories

  sl.registerLazySingleton<AiRepository>(
    () => AiRepositoryImpl(
      remoteDataSource: sl.call(),
    ),
  );
  sl.registerLazySingleton<AiRemoteDataSource>(
    () => AiRemoteDataSourceImpl(
      preferences: sl.call(),
    ),
  );
}
