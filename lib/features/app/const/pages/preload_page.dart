import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:password_manager/features/app/const/pages/splash_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PreloadPage extends StatefulWidget {
  const PreloadPage({super.key});

  @override
  State<PreloadPage> createState() => _PreloadPageState();
}

class _PreloadPageState extends State<PreloadPage> {
  bool isAuthScreenShown = false;
  bool showAuthScreen = true;
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onStateChange: (value) {},
      onResume: () {
        if (isAuthScreenShown) {
          return;
        } else {
          setState(() {
            showAuthScreen = true;
          });
        }
      },
    );
    _listener();
  }

  @override
  Widget build(BuildContext context) {
    return SplashPage();
  }
}
