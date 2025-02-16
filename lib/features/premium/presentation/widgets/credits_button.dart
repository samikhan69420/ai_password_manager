import 'package:shadcn_flutter/shadcn_flutter.dart';

class CreditsButton extends StatelessWidget {
  final int amount;
  final double price;
  const CreditsButton({super.key, required this.amount, required this.price});

  @override
  Widget build(BuildContext context) {
    return Button.card(
      onPressed: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            RadixIcons.outerShadow,
            size: 40,
          ),
          Gap(10),
          Basic(
            titleAlignment: Alignment.center,
            subtitleAlignment: Alignment.center,
            title: Text(
              "$amount Credits",
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text(
              "\$$price",
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
