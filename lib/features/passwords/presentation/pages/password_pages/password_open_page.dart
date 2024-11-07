// ignore_for_file: unused_import, implementation_imports
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/app/const/classes_functions/check_empty.dart';
import 'package:password_manager/features/app/const/classes_functions/string_const.dart';
import 'package:password_manager/features/passwords/domain/entities/password_entity.dart';
import 'package:password_manager/features/passwords/presentation/cubit/passwords_cubit.dart';
import 'package:password_manager/features/passwords/presentation/widgets/open_password_container.dart';
import 'package:password_manager/features/passwords/presentation/widgets/password_types/address.dart';
import 'package:password_manager/features/passwords/presentation/widgets/password_types/credit_card.dart';
import 'package:password_manager/features/passwords/presentation/widgets/password_types/email_password.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:toastification/toastification.dart';

class PasswordOpenPage extends StatefulWidget {
  final PasswordEntity passwordEntity;
  const PasswordOpenPage({super.key, required this.passwordEntity});

  @override
  State<PasswordOpenPage> createState() => _PasswordOpenPageState();
}

class _PasswordOpenPageState extends State<PasswordOpenPage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();

  final TextEditingController addressLineController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController postalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.value =
        TextEditingValue(text: widget.passwordEntity.username!);
    passwordController.value =
        TextEditingValue(text: widget.passwordEntity.password!);
    cardNumberController.value = TextEditingValue(
        text: widget.passwordEntity.creditCardInfo![StringConst.cardNumber]!);
    monthController.value = TextEditingValue(
        text: widget.passwordEntity.creditCardInfo![StringConst.monthYear]!);
    cvcController.value = TextEditingValue(
        text: widget.passwordEntity.creditCardInfo![StringConst.cvc]!);
    addressLineController.value = TextEditingValue(
        text: widget.passwordEntity.otherFields![StringConst.addressLine1]!);
    streetController.value = TextEditingValue(
        text: widget.passwordEntity.otherFields![StringConst.street]!);
    postalController.value = TextEditingValue(
        text: widget.passwordEntity.otherFields![StringConst.postalCode]!);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cardNumberController.dispose();
    monthController.dispose();
    cvcController.dispose();
    addressLineController.dispose();
    streetController.dispose();
    postalController.dispose();
    super.dispose();
  }

  bool creditCardVisible = true;
  bool addressVisible = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<int> notEmptyList = checkEmpty(widget.passwordEntity);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        headers: [
          AppBar(
            title: TextField(
              border: false,
              controller: titleController,
              initialValue: widget.passwordEntity.title,
              padding: const EdgeInsets.all(0),
              style: theme.typography.h4,
            ),
            trailing: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<PasswordsCubit>(context).updatePassword(
                    newPassword: PasswordEntity(
                      passwordIdentifier:
                          widget.passwordEntity.passwordIdentifier,
                      title: titleController.text,
                      username: emailController.text,
                      password: passwordController.text,
                      creditCardInfo: {
                        'cardNumber': cardNumberController.text,
                        'monthYear': monthController.text,
                        'cvc': cvcController.text,
                      },
                      otherFields: {
                        'addressLine1': addressLineController.text,
                        'street': streetController.text,
                        'postalCode': postalController.text,
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.check),
                variance: ButtonVariance.ghost,
              ),
            ],
          )
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                notEmptyList.contains(0)
                    ? OpenPasswordContainer(
                        title: "Email Password",
                        child: EmailPassword(
                          border: false,
                          active: true,
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
                      )
                    : Container(),
                const Gap(10),
                notEmptyList.contains(1)
                    ? OpenPasswordContainer(
                        visibility: true,
                        title: 'Credit Card',
                        child: CreditCard(
                          border: false,
                          active: true,
                          hidden: creditCardVisible,
                          cardNumberController: cardNumberController,
                          monthController: monthController,
                          cvcController: cvcController,
                        ),
                      )
                    : Container(),
                const Gap(10),
                notEmptyList.contains(2)
                    ? OpenPasswordContainer(
                        visibility: true,
                        title: 'Address',
                        child: Address(
                          border: false,
                          active: true,
                          obscure: addressVisible,
                          addressLineController: addressLineController,
                          postalController: postalController,
                          streetController: streetController,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
