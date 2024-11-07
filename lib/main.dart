import 'package:password_manager/features/ai/presentation/cubit/ai_cubit/ai_cubit.dart';
import 'package:password_manager/features/ai/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:password_manager/features/app/const/pages/onboarding_page.dart';
import 'package:password_manager/features/passwords/presentation/cubit/passwords_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/passwords/presentation/pages/auth_page/auth_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'main_injection_container.dart' as di;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SharedPreferences preferences = di.sl();
    final bool firstTime = preferences.getBool('firstTime') ?? true;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PasswordsCubit(
            updatePasswordUsecase: di.sl(),
            getPasswordUsecase: di.sl(),
            deletePasswordUsecase: di.sl(),
            createPasswordUsecase: di.sl(),
          ),
        ),
        BlocProvider(
          create: (context) => AiCubit(
            getAiPasswordUsecase: di.sl(),
          ),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(
            getProfileUsecase: di.sl(),
            setProfileUsecase: di.sl(),
            updateProfileUsecase: di.sl(),
          ),
        ),
      ],
      child: ToastificationWrapper(
        config: const ToastificationConfig(
          alignment: Alignment.center,
        ),
        child: ShadcnApp(
          theme: ThemeData(
            radius: 1,
            colorScheme: ColorSchemes.darkZinc(),
          ),
          home: firstTime ? const OnboardingPage() : const AuthPage(),
        ),
      ),
    );
  }
}
