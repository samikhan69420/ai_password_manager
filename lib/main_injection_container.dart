import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_manager/features/ai/ai_injection_container.dart';
import 'package:password_manager/features/passwords/password_injection_container.dart';
import 'package:get_it/get_it.dart';
import 'package:password_manager/features/premium/premium_injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final LocalAuthentication localAuth = LocalAuthentication();

  sl.registerLazySingleton(() => preferences);
  sl.registerLazySingleton(() => storage);
  sl.registerLazySingleton(() => localAuth);

  await passwordInjectionContainer();
  await aiInjectionContainer();
  await premiumInjectionContainer();
}
