import 'dart:ui';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void showCreditsDialog(BuildContext context) {
  showGeneralDialog(
    barrierLabel: "HII",
    context: context,
    barrierDismissible: true,
    pageBuilder: (context, animation, secondaryAnimation) => GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: SizedBox.expand(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Card(
              child: Basic(
                title: Row(
                  children: [
                    Icon(
                      RadixIcons.infoCircled,
                      size: 25,
                    ),
                    Gap(10),
                    Text("Not enough credits"),
                  ],
                ),
                subtitle: Text("Watch an advertisement or get Passman premium"),
                content: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Button.primary(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Ok"),
                      ),
                    ],
                  ),
                ),
              ),
            )
                .animate()
                .moveY(curve: Curves.easeOutCirc)
                .scale(
                    curve: Curves.easeOutCirc,
                    duration: 700.ms,
                    begin: Offset(0.9, 0.9))
                .fadeIn()
                .blur(begin: Offset(5, 5), end: Offset.zero),
          ),
        ],
      ),
    ),
  );
}
