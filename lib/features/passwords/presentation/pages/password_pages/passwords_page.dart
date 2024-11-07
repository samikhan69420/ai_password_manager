import 'package:animations/animations.dart';
import 'package:lottie/lottie.dart';
import 'package:password_manager/features/app/const/classes_functions/string_const.dart';
import 'package:password_manager/features/passwords/presentation/cubit/passwords_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/passwords/presentation/pages/password_pages/create_password_page.dart';
import 'package:password_manager/features/passwords/presentation/pages/password_pages/password_open_page.dart';
import 'package:password_manager/features/ai/presentation/pages/profile_page/profile_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import '../../../domain/entities/password_entity.dart';

class PasswordsPage extends StatefulWidget {
  const PasswordsPage({super.key});

  @override
  State<PasswordsPage> createState() => _PasswordsPageState();
}

class _PasswordsPageState extends State<PasswordsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PasswordsCubit>(context).getAiPassword();
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
          title: const Text("Your Passwords"),
          trailing: [
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
                      const Center(
                        child: Text('No password created'),
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
                  padding: const EdgeInsets.only(top: 72, left: 20, right: 20),
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
                "state.props",
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
