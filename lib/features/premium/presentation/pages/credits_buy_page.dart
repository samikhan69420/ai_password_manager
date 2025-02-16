import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/premium/presentation/cubit/premium_cubit_cubit.dart';
import 'package:password_manager/features/premium/presentation/widgets/credits_button.dart';
import 'package:password_manager/features/premium/presentation/widgets/premium_buy_drawer.dart';
import 'package:password_manager/features/premium/presentation/widgets/staggered_coulumn.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CreditsPage extends StatefulWidget {
  const CreditsPage({super.key});

  @override
  State<CreditsPage> createState() => _CreditsPageState();
}

class _CreditsPageState extends State<CreditsPage> {
  @override
  void initState() {
    BlocProvider.of<PremiumCubit>(context).getCredits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PremiumCubit, PremiumCubitState>(
      builder: (context, state) {
        if (state is PremiumCubitLoaded) {
          return bodyWidget(context, uiCredits: state.credits);
        } else {
          return bodyWidget(context);
        }
      },
    );
  }

  Widget bodyWidget(BuildContext context, {double? uiCredits}) {
    int credits = (uiCredits ?? 0).toInt();
    return Scaffold(
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StaggeredCoulumn(
                place: 1,
                children: [
                  IconButton.ghost(
                    onPressed: () {},
                    icon: Icon(RadixIcons.outerShadow),
                    size: ButtonSize(4),
                  ),
                  Gap(20),
                  Basic(
                    titleAlignment: Alignment.center,
                    subtitleAlignment: Alignment.center,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You have ").h3(),
                        Text(credits.toString()).h3(),
                        Text(" Credits").h3(),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "You can store $credits passwords and generate ${(credits / 5).floor()} AI passwords",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: StaggeredCoulumn(
                  place: 4,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Button.card(
                        onPressed: () {
                          BlocProvider.of<PremiumCubit>(context)
                              .showVideoAd(context);
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, right: 20),
                              child: Icon(BootstrapIcons.cameraReels),
                            ),
                            Basic(
                              title: Text("Watch an ad"),
                              subtitle: Text(
                                  "Watch an advertisement to get 10 credits"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(10),
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Button.card(
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 20),
                                  child: Icon(RadixIcons.mix),
                                ),
                                Basic(
                                  title: Text("Buy Passman premium"),
                                  subtitle: Text(
                                      "Store and create unlimited passwords!"),
                                ),
                              ],
                            ),
                            onPressed: () {
                              openDrawer(
                                context: context,
                                position: OverlayPosition.bottom,
                                builder: (context) {
                                  return PremiumBuyDrawer();
                                },
                              );
                            },
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(10, -35),
                          child: Transform.rotate(
                            angle: 0.2,
                            child: Align(
                                alignment: Alignment.topRight,
                                child: PrimaryBadge(child: Text("Save 80%"))),
                          ),
                        )
                      ],
                    ),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: CreditsButton(amount: 20, price: 0.99)),
                        Expanded(
                            child: CreditsButton(amount: 120, price: 4.99)),
                        Expanded(
                            child: CreditsButton(amount: 300, price: 9.99)),
                      ],
                    ).gap(10),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
