import 'package:password_manager/features/app/const/pages/set_profile_page.dart';
import 'package:password_manager/features/app/const/widgets/expanded_page_view.dart';
import 'package:password_manager/features/app/const/widgets/onboarding_item.dart';
import 'package:password_manager/features/passwords/presentation/pages/password_pages/passwords_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:password_manager/main_injection_container.dart' as di;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController(initialPage: 0);
  bool buttonVisible = false;
  @override
  void initState() {
    super.initState();
    final SharedPreferences preferences = di.sl();
    final bool firstTime = preferences.getBool('firstTime') ?? true;

    if (firstTime == false) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const PasswordsPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          ExpandablePageView(
            controller: pageController,
            itemCount: 3,
            itemBuilder: (context, index) => OnboardingItem(
              title: <String>[
                "Introducing Passman",
                "Never Forget a password",
                "AI",
              ][index],
              subtitle: <String>[
                "All your passwords in a single page.",
                "About 37% of accounts are lost due to forgotten passwords",
                "Make random passwords that are easy to remember with AI",
              ][index],
              icon: <IconData>[
                RadixIcons.lockClosed,
                RadixIcons.magnifyingGlass,
                BootstrapIcons.stars,
              ][index],
            ),
          ),
          const Gap(50),
          SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: CustomizableEffect(
              dotDecoration: DotDecoration(
                color: colorScheme.background,
                borderRadius: BorderRadius.circular(100),
                dotBorder: DotBorder(
                  color: colorScheme.border,
                  width: 2,
                ),
                height: 12,
                width: 12,
              ),
              activeDotDecoration: DotDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(100),
                height: 12,
                width: 12,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: SizedBox(
              width: double.infinity,
              child: Button.primary(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SetProfilePage(),
                    ),
                  );
                },
                child: const Text("Continue"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
