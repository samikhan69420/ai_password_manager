import 'package:password_manager/features/passwords/data/datasources/remote_data_source.dart';
import 'package:password_manager/features/passwords/data/datasources/remote_data_source_impl.dart';
import 'package:password_manager/features/passwords/data/repositories/password_repository_impl.dart';
import 'package:password_manager/features/passwords/domain/repositories/password_repository.dart';
import 'package:password_manager/features/passwords/domain/usecases/delete_password_usecase.dart';
import 'package:password_manager/features/passwords/domain/usecases/get_password_usecase.dart';
import 'package:password_manager/features/passwords/domain/usecases/create_password_usecase.dart';
import 'package:password_manager/features/passwords/domain/usecases/update_password_usecase.dart';
import 'package:password_manager/features/passwords/presentation/cubit/passwords_cubit.dart';
import 'package:password_manager/main_injection_container.dart';

Future<void> passwordInjectionContainer() async {
  // Cubit

  sl.registerFactory<PasswordsCubit>(
    () => PasswordsCubit(
      updatePasswordUsecase: sl.call(),
      createPasswordUsecase: sl.call(),
      getPasswordUsecase: sl.call(),
      deletePasswordUsecase: sl.call(),
    ),
  );

  // Usecases

  sl.registerLazySingleton<GetPasswordUsecase>(
    () => GetPasswordUsecase(repository: sl.call()),
  );
  sl.registerLazySingleton<CreatePasswordUsecase>(
    () => CreatePasswordUsecase(repository: sl.call()),
  );
  sl.registerLazySingleton<DeletePasswordUsecase>(
    () => DeletePasswordUsecase(repository: sl.call()),
  );
  sl.registerLazySingleton<UpdatePasswordUsecase>(
    () => UpdatePasswordUsecase(repository: sl.call()),
  );

  // Repositories

  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(sharedPreferences: sl.call()),
  );
  sl.registerLazySingleton<PasswordRepository>(
    () => PasswordRepositoryImpl(remoteDataSource: sl.call()),
  );
}
