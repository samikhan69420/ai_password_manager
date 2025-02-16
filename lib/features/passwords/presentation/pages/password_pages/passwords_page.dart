import 'package:animations/animations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:password_manager/features/app/const/classes_functions/string_const.dart';
import 'package:password_manager/features/passwords/presentation/cubit/passwords_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/passwords/presentation/pages/password_pages/create_password_page.dart';
import 'package:password_manager/features/passwords/presentation/pages/password_pages/password_open_page.dart';
import 'package:password_manager/features/ai/presentation/pages/profile_page/profile_page.dart';
import 'package:password_manager/features/premium/presentation/cubit/premium_cubit_cubit.dart';
import 'package:password_manager/features/premium/presentation/pages/credits_buy_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../../../domain/entities/password_entity.dart';

class PasswordsPage extends StatefulWidget {
  const PasswordsPage({super.key});

  @override
  State<PasswordsPage> createState() => _PasswordsPageState();
}

class _PasswordsPageState extends State<PasswordsPage>
    with TickerProviderStateMixin {
  late final Animation<double> animation;
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: 2.seconds);
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    Future.delayed(3000.ms).then(
      (value) => controller.forward(),
    );
    super.initState();
    BlocProvider.of<PasswordsCubit>(context).getAiPassword();
    BlocProvider.of<PremiumCubit>(context).getCredits();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      floatingHeader: true,
      floatingFooter: true,
      headers: [
        AppBar(
          surfaceBlur: 3,
          surfaceOpacity: 0.5,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/passman.svg',
                height: 45,
              ),
              Gap(5),
              Text("Passman"),
            ],
          ),
          trailing: [
            Button.outline(
              child: Row(
                children: [
                  const Icon(
                    RadixIcons.shadowOuter,
                    size: 20,
                  ),
                  Gap(10),
                  BlocBuilder<PremiumCubit, PremiumCubitState>(
                    builder: (context, state) {
                      if (state is PremiumCubitLoaded) {
                        final credits = state.credits;
                        return Text(
                          credits.toInt().toString(),
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreditsPage(),
                    ));
              },
            ),
            IconButton.outline(
              icon: const Icon(RadixIcons.person),
              onPressed: () {
                openDrawer(
                  context: context,
                  builder: (context) => const ProfilePage(),
                  position: OverlayPosition.right,
                );
              },
            ),
          ],
        ),
      ],
      footers: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OpenContainer(
                openBuilder: (context, action) => const CreatePasswordPage(),
                middleColor: Colors.transparent,
                closedColor: colorScheme.primary,
                openColor: Colors.transparent,
                transitionDuration: const Duration(milliseconds: 500),
                closedShape:
                    RoundedRectangleBorder(borderRadius: theme.borderRadiusLg),
                useRootNavigator: true,
                closedBuilder: (context, action) => SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
      child: BlocBuilder<PasswordsCubit, PasswordState>(
        builder: (context, state) {
          if (state is PasswordLoading) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            );
          } else if (state is PasswordLoaded) {
            return StreamBuilder<List<PasswordEntity>>(
              stream: state.streamResponse,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error occurred while loading passwords'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/passman_lock.svg',
                              height: 100,
                            )
                                .animate()
                                .moveY(curve: Curves.easeOutCirc)
                                .scale(
                                    curve: Curves.easeOutCirc,
                                    duration: 1500.ms,
                                    begin: Offset(0.9, 0.9))
                                .fadeIn()
                                .blur(begin: Offset(5, 5), end: Offset.zero),
                            Gap(30),
                            Text('No password created')
                                .animate(delay: 50.ms)
                                .moveY(curve: Curves.easeOutCirc)
                                .scale(
                                    curve: Curves.easeOutCirc,
                                    duration: 1500.ms,
                                    begin: Offset(0.9, 0.9))
                                .fadeIn()
                                .blur(begin: Offset(5, 5), end: Offset.zero),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(70),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Transform.rotate(
                            angle: 3.3,
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Lottie.asset(
                                controller: controller,
                                'assets/attention_grabby.json',
                                repeat: false,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                final passwordList = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 80,
                  ),
                  child: ListView.builder(
                    itemCount: passwordList.length,
                    itemBuilder: (context, index) {
                      final password = passwordList[index];
                      List<String> getPasswordTypes() {
                        List<String> passTypeList = [];
                        if (password.username != null &&
                            password.username!.isNotEmpty) {
                          passTypeList.add('Email');
                        }
                        if (password.creditCardInfo![StringConst.cardNumber]!
                            .isNotEmpty) {
                          passTypeList.add('Credit Card');
                        }
                        if (password.otherFields != null &&
                            password.otherFields![StringConst.addressLine1]!
                                .isNotEmpty) {
                          passTypeList.add('Address');
                        }
                        return passTypeList;
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: OpenContainer(
                          useRootNavigator: true,
                          transitionDuration: const Duration(milliseconds: 300),
                          closedColor: colorScheme.background,
                          middleColor: colorScheme.background,
                          openColor: colorScheme.background,
                          closedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Theme.of(context).radiusXl),
                            side: BorderSide(color: colorScheme.border),
                          ),
                          openBuilder: (context, action) =>
                              PasswordOpenPage(passwordEntity: password),
                          closedBuilder: (context, action) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Basic(
                              title: Text(password.title!),
                              subtitle: Text(getPasswordTypes().join(', ')),
                              trailing: IconButton(
                                variance: ButtonVariance.ghost,
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  BlocProvider.of<PasswordsCubit>(context)
                                      .deletePassword(
                                          passwordIdentifier:
                                              password.passwordIdentifier);
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is PasswordError) {
            return Center(
              child: Text(
                state.errorMsg!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(
                "Unexpected Error",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
