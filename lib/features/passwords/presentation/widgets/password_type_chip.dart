import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter/material.dart' as mat;

class PasswordTypeChip extends StatefulWidget {
  final bool active;
  final VoidCallback? onTap;
  final String text;
  const PasswordTypeChip(
      {super.key, required this.active, this.onTap, required this.text});

  @override
  State<PasswordTypeChip> createState() => _PasswordTypeChipState();
}

class _PasswordTypeChipState extends State<PasswordTypeChip> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: mat.Easing.standardDecelerate,
        height: 35,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: theme.borderRadiusMd,
          color: widget.active ? colorScheme.primary : colorScheme.secondary,
        ),
        child: mat.Center(
          child: Text(widget.text,
              style: TextStyle(
                color: widget.active
                    ? Colors.black
                    : theme.typography.textSmall.color,
                fontSize: theme.typography.textSmall.fontSize,
                fontWeight: theme.typography.textSmall.fontWeight,
              )),
        ),
      ),
    );
  }
}
