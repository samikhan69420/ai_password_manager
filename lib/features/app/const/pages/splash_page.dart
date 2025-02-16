import 'package:lottie/lottie.dart';
import 'package:password_manager/features/app/const/pages/onboarding_page.dart';
import 'package:password_manager/features/passwords/presentation/pages/auth_page/auth_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:password_manager/main_injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    final SharedPreferences preferences = di.sl();
    final bool firstTime = preferences.getBool('firstTime') ?? true;

    Future.delayed(Duration(milliseconds: 2500)).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                firstTime ? const OnboardingPage() : AuthPage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Center(
        child: Lottie.asset("assets/passman_splash.json", repeat: false),
      ),
    );
  }
}
