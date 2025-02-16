import 'package:flutter_animate/flutter_animate.dart';
import 'package:password_manager/features/ai/presentation/cubit/ai_cubit/ai_cubit.dart';
import 'package:password_manager/features/ai/presentation/cubit/profile_cubit/profile_cubit.dart';

import 'package:password_manager/features/app/const/pages/splash_page.dart';
import 'package:password_manager/features/passwords/presentation/cubit/passwords_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/premium/presentation/cubit/premium_cubit_cubit.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'main_injection_container.dart' as di;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  Animate.restartOnHotReload = true;
  await di.init();
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PremiumCubit(
            showVideoAdUsecase: di.sl(),
            addCreditsUsecase: di.sl(),
            removeCreditsUsecase: di.sl(),
            getCreditsUsecase: di.sl(),
          ),
        ),
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
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            radius: 1,
            colorScheme: ColorSchemes.darkZinc(),
          ),
          home: SplashPage(),
        ),
      ),
    );
  }
}
