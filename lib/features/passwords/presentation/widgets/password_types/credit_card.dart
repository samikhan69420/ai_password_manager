import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CreditCard extends StatelessWidget {
  final bool active;

  final bool border;

  final bool hidden;

  final TextEditingController cardNumberController;
  final TextEditingController monthController;
  final TextEditingController cvcController;

  const CreditCard({
    super.key,
    this.active = false,
    this.border = true,
    this.hidden = true,
    required this.cardNumberController,
    required this.monthController,
    required this.cvcController,
  });

  @override
  Widget build(BuildContext context) {
    return active
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                TextField(
                  obscureText: hidden,
                  border: border,
                  padding: border ? null : const EdgeInsets.all(0),
                  controller: cardNumberController,
                  placeholder: "Card Number",
                  maxLength: 16,
                  inputFormatters: [CreditCardNumberInputFormatter()],
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        obscureText: hidden,
                        border: border,
                        padding: border ? null : const EdgeInsets.all(0),
                        controller: monthController,
                        placeholder: "MM/YY",
                        inputFormatters: [
                          CreditCardExpirationDateFormatter(),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextField(
                        obscureText: hidden,
                        border: border,
                        padding: border ? null : const EdgeInsets.all(0),
                        controller: cvcController,
                        placeholder: "CVC",
                        inputFormatters: [
                          CreditCardCvcInputFormatter(),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container();
  }
}
