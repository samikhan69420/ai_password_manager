import 'package:shadcn_flutter/shadcn_flutter.dart';

class OnboardingItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const OnboardingItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: theme.borderRadiusLg,
          border: Border.all(color: colorScheme.border),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Icon(
                icon,
                size: theme.iconTheme.x4Large.size,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(title).h4(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
                top: 10,
                bottom: 40,
              ),
              child: Text(subtitle),
            ),
          ],
        ),
      ),
    );
  }
}
