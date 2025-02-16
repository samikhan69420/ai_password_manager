import 'package:password_manager/features/premium/presentation/pages/shapes_animation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PremiumBuyDrawer extends StatefulWidget {
  const PremiumBuyDrawer({super.key});

  @override
  State<PremiumBuyDrawer> createState() => _PremiumBuyDrawerState();
}

class _PremiumBuyDrawerState extends State<PremiumBuyDrawer> {
  int? selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: ShapesAnimation(),
        ),
        Divider(
          padding: EdgeInsets.all(10),
          thickness: 3,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Basic(
            subtitle: Text("Choose a plan").bold(),
            content: RadioGroup<int>(
              onChanged: (value) {
                setState(() {
                  selected = value;
                });
              },
              value: selected,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    RadioCard(
                      value: 1,
                      child: Row(
                        children: [
                          Radio(value: selected == 1),
                          Gap(15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Monthly"),
                              Text("\$2.99").muted().xSmall(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gap(20),
                    RadioCard(
                      value: 2,
                      child: Row(
                        children: [
                          Radio(value: selected == 2),
                          Gap(15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Yearly"),
                              Text("\$29.99").muted().xSmall(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: double.infinity,
            child: Button.primary(
              onPressed: () {},
              child: Text("Purchase"),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 10, bottom: 20, right: 20),
          child: Text(
            "By clicking \"Purchase\" you accept that what you're purchasing is a recurring subscription, which means that you will be charged ${(selected ?? 1) == 1 ? "montly" : "yearly"}",
            style: TextStyle(fontSize: 14),
          ),
        )
      ],
    );
  }
}
