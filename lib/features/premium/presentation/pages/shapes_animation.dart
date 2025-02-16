import 'dart:async';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ShapesAnimation extends StatefulWidget {
  const ShapesAnimation({super.key});

  @override
  State<ShapesAnimation> createState() => _PremiumBuyPageState();
}

class _PremiumBuyPageState extends State<ShapesAnimation> {
  List<String> assets = [
    'assets/shapes/circle.svg',
    'assets/shapes/rectangle.svg',
    'assets/shapes/star.svg',
    'assets/shapes/triangle.svg',
  ];

  int active = 0;

  late final Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(
      2.seconds,
      (timer) {
        if (mounted) {
          if (active == 3) {
            setState(() {
              active = 0;
            });
          } else {
            setState(() {
              active++;
            });
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          assets.length,
          (index) {
            return Stack(
              alignment: Alignment.center,
              children: [
                active == index
                    ? text(index)
                        .animate()
                        .blur(
                            duration: 500.ms,
                            curve: Curves.easeOutCirc,
                            begin: Offset(5, 5),
                            end: Offset.zero)
                        .slideY(
                          begin: 3.5,
                          end: 2.5,
                          curve: Curves.easeOutCirc,
                          duration: 500.ms,
                        )
                        .fadeIn()
                    : Opacity(
                        opacity: 0,
                        child: text(index),
                      ),
                active == index
                    ? SvgPicture.asset(
                        assets[index],
                        height: 70,
                      ).animate().slideY(
                          begin: 0,
                          end: -.2,
                          curve: Curves.easeOutCirc,
                          duration: 500.ms,
                        )
                    : SvgPicture.asset(
                        assets[index],
                        height: 70,
                      ),
              ],
            )
                .animate(
                  delay: ((index + 1) * 100).ms,
                )
                .moveY(curve: Curves.easeOutCirc, duration: 500.ms)
                .scale(
                    curve: Curves.easeOutCirc,
                    duration: 1000.ms,
                    begin: Offset(0.9, 0.9))
                .fadeIn()
                .blur(begin: Offset(5, 5), end: Offset.zero);
          },
        ),
      ).gap(50),
    );
  }

  Widget text(int index) {
    return Text(
      ['Store', 'Manage', 'Generate', 'Secure'][index],
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
