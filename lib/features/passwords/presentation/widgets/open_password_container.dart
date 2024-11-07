import 'package:password_manager/features/passwords/presentation/widgets/password_types/address.dart';
import 'package:password_manager/features/passwords/presentation/widgets/password_types/credit_card.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class OpenPasswordContainer extends StatefulWidget {
  final String title;
  final Widget child;
  bool? visibility;
  OpenPasswordContainer({
    super.key,
    required this.child,
    required this.title,
    this.visibility,
  });

  @override
  State<OpenPasswordContainer> createState() => _OpenPasswordContainerState();
}

class _OpenPasswordContainerState extends State<OpenPasswordContainer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.border),
        color: colorScheme.background,
        borderRadius: BorderRadius.circular(Theme.of(context).radiusXl),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              widget.visibility != null
                  ? IconButton(
                      icon: Icon(widget.visibility!
                          ? RadixIcons.eyeClosed
                          : RadixIcons.eyeOpen),
                      onPressed: () {
                        setState(() {
                          widget.visibility = !widget.visibility!;
                        });
                      },
                      variance: ButtonVariance.ghost)
                  : Container(),
            ],
          ),
          if (widget.child is CreditCard)
            CreditCard(
              cardNumberController:
                  (widget.child as CreditCard).cardNumberController,
              monthController: (widget.child as CreditCard).monthController,
              cvcController: (widget.child as CreditCard).cvcController,
              active: (widget.child as CreditCard).active,
              hidden: widget.visibility!,
              border: (widget.child as CreditCard).border,
            )
          else if (widget.child is Address)
            Address(
              addressLineController:
                  (widget.child as Address).addressLineController,
              postalController: (widget.child as Address).postalController,
              streetController: (widget.child as Address).streetController,
              active: (widget.child as Address).active,
              border: (widget.child as Address).border,
              obscure: widget.visibility!,
            )
          else
            widget.child,
        ],
      ),
    );
  }
}
