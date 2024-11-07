import 'package:local_auth/local_auth.dart';
import 'package:password_manager/features/ai/ai_injection_container.dart';
import 'package:password_manager/features/passwords/password_injection_container.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  final LocalAuthentication localAuth = LocalAuthentication();

  sl.registerLazySingleton(
    () => sharedPreferences,
  );
  sl.registerLazySingleton(
    () => localAuth,
  );
  await passwordInjectionContainer();
  await aiInjectionContainer();
}
