import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StaggeredCoulumn extends StatelessWidget {
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final int? place;
  final List<Widget> children;
  const StaggeredCoulumn(
      {super.key,
      required this.children,
      this.place,
      this.mainAxisAlignment,
      this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: children.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        int uiIndex = index;
        uiIndex += (place ?? 0);
        return children[index]
            .animate(delay: (uiIndex * 50).ms)
            .moveY(curve: Curves.easeOutCirc)
            .scale(
                curve: Curves.easeOutCirc,
                duration: 1500.ms,
                begin: Offset(0.9, 0.9))
            .fadeIn()
            .blur(begin: Offset(5, 5), end: Offset.zero);
      },
    );
  }
}
