import 'package:shadcn_flutter/shadcn_flutter.dart';

class Address extends StatelessWidget {
  bool active;

  final bool border;

  final bool obscure;

  final TextEditingController addressLineController;
  final TextEditingController streetController;
  final TextEditingController postalController;

  Address({
    super.key,
    this.active = false,
    this.border = true,
    this.obscure = true,
    required this.addressLineController,
    required this.postalController,
    required this.streetController,
  });

  @override
  Widget build(BuildContext context) {
    return active
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                TextField(
                  obscureText: obscure,
                  border: border,
                  padding: border ? null : const EdgeInsets.all(0),
                  controller: addressLineController,
                  placeholder: Text("Address Line 1"),
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        obscureText: obscure,
                        border: border,
                        padding: border ? null : const EdgeInsets.all(0),
                        controller: streetController,
                        placeholder: Text("Street"),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: TextField(
                        obscureText: obscure,
                        border: border,
                        padding: border ? null : const EdgeInsets.all(0),
                        controller: postalController,
                        placeholder: Text("Postal Code"),
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
