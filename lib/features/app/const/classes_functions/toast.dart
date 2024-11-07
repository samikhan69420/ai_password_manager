import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:toastification/toastification.dart';

void showToastification(String title) {
  toastification.show(
    style: ToastificationStyle.simple,
    alignment: Alignment.center,
    autoCloseDuration: const Duration(milliseconds: 2000),
    applyBlurEffect: true,
    borderSide: const BorderSide(color: Color.fromARGB(255, 33, 33, 35)),
    backgroundColor: Colors.black,
    title: Text(title),
  );
}
