import 'package:local_auth/local_auth.dart';
import 'package:password_manager/features/passwords/presentation/pages/password_pages/passwords_page.dart';
import 'package:password_manager/main_injection_container.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AuthPage extends StatefulWidget {
  final VoidCallback? onAuthCompleted;
  final Function(bool isShown)? onAuthChanged;
  const AuthPage({
    super.key,
    this.onAuthCompleted,
    this.onAuthChanged,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final LocalAuthentication auth = sl();
  bool authSuccess = false;

  Future<bool> didAuthenticate() async {
    widget.onAuthChanged?.call(true);
    return await auth.authenticate(localizedReason: ' ');
  }

  @override
  void initState() {
    super.initState();
    didAuthenticate().then(
      (authenticated) {
        if (authenticated && mounted) {
          widget.onAuthChanged?.call(false);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const PasswordsPage(),
            ),
            (route) => false,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Icon(
            authSuccess ? RadixIcons.lockOpen2 : RadixIcons.lockClosed,
            size: theme.iconTheme.x4Large.size,
          ),
          const Gap(30),
          const Text(
            "Please login to access your passwords",
            textAlign: TextAlign.center,
          ).h4(),
          const Spacer(),
          IconButton.outline(
            icon: const Icon(BootstrapIcons.fingerprint),
            size: ButtonSize.large,
            onPressed: () {
              didAuthenticate().then(
                (authenticated) {
                  if (authenticated && mounted) {
                    (widget.onAuthCompleted ?? () {})();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PasswordsPage(),
                      ),
                      (route) => false,
                    );
                    setState(() {
                      authSuccess = true;
                    });
                  }
                },
              );
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          )
        ],
      ),
    );
  }
}
