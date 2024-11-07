// ignore_for_file: implementation_imports, unused_import
import 'dart:ui';

import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/ai/domain/entities/user_entity.dart';
import 'package:password_manager/features/ai/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:password_manager/features/ai/presentation/pages/profile_page/profile_page.dart';
import 'package:password_manager/features/passwords/presentation/widgets/ai_password_sheet.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class EmailPassword extends StatefulWidget {
  final bool border;

  final TextStyle? textStyle;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  bool active;
  EmailPassword({
    super.key,
    this.textStyle,
    this.active = false,
    this.border = true,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<EmailPassword> createState() => _EmailPasswordState();
}

class _EmailPasswordState extends State<EmailPassword> {
  bool visible = false;

  UserEntity? userEntity;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return widget.active
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                TextField(
                  style: widget.textStyle,
                  border: widget.border,
                  padding: widget.border ? null : const EdgeInsets.all(0),
                  controller: widget.emailController,
                  useNativeContextMenu: true,
                  placeholder: 'Email / Username',
                ),
                const Gap(10),
                TextField(
                  border: widget.border,
                  padding: widget.border ? null : const EdgeInsets.all(0),
                  controller: widget.passwordController,
                  useNativeContextMenu: true,
                  placeholder: 'Password',
                  obscureText: widget.border ? false : !visible,
                  trailing: widget.border
                      ? IconButton(
                          icon: const Icon(BootstrapIcons.stars),
                          alignment: Alignment.center,
                          variance: ButtonVariance.ghost,
                          onPressed: () {
                            openDrawer(
                              context: context,
                              builder: (context) => Column(
                                children: [
                                  BlocBuilder<ProfileCubit, ProfileState>(
                                    builder: (context, state) {
                                      if (state is ProfileLoaded) {
                                        return AiPasswordSheet(
                                          userEntity: state.userEntity,
                                          passwordController:
                                              widget.passwordController,
                                        );
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    },
                                  ),
                                ],
                              ),
                              transformBackdrop: true,
                              barrierDismissible: true,
                              showDragHandle: false,
                              barrierColor: Colors.black.withAlpha(100),
                              position: OverlayPosition.bottom,
                            );
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            !visible
                                ? RadixIcons.eyeClosed
                                : RadixIcons.eyeOpen,
                          ),
                          variance: ButtonVariance.ghost,
                          onPressed: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                        ),
                ),
              ],
            ),
          )
        : Container();
  }
}
