import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/app/const/classes_functions/string_const.dart';
import 'package:password_manager/features/app/const/classes_functions/toast.dart';
import 'package:password_manager/features/passwords/domain/entities/password_entity.dart';
import 'package:password_manager/features/passwords/presentation/cubit/passwords_cubit.dart';
import 'package:password_manager/features/passwords/presentation/widgets/password_type_chip.dart';
import 'package:password_manager/features/passwords/presentation/widgets/password_types/address.dart';
import 'package:password_manager/features/passwords/presentation/widgets/password_types/email_password.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widgets/password_types/credit_card.dart';

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({super.key});

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();

  final TextEditingController addressLineController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController postalController = TextEditingController();

  List<int> selected = [0];
  @override
  void dispose() {
    titleController.dispose();

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        floatingHeader: false,
        headers: [
          AppBar(
            leading: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(RadixIcons.arrowLeft),
                  variance: ButtonVariance.ghost)
            ],
            title: Text("Create Password"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  PasswordTypeChip(
                    text: "Email Password",
                    active: selected.contains(0),
                    onTap: () {
                      if (selected.contains(0)) {
                        setState(() {
                          selected.remove(0);
                        });
                      } else {
                        setState(() {
                          selected.add(0);
                        });
                      }
                    },
                  ),
                  PasswordTypeChip(
                    text: "Credit Card",
                    active: selected.contains(1),
                    onTap: () {
                      if (selected.contains(1)) {
                        setState(() {
                          selected.remove(1);
                        });
                      } else {
                        setState(() {
                          selected.add(1);
                        });
                      }
                    },
                  ),
                  PasswordTypeChip(
                    text: "Address",
                    active: selected.contains(2),
                    onTap: () {
                      if (selected.contains(2)) {
                        setState(() {
                          selected.remove(2);
                        });
                      } else {
                        setState(() {
                          selected.add(2);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
        child: selected.isEmpty
            ? const Center(
                child: Text("Please Select a Password"),
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: theme.borderRadiusXl,
                        border: Border.all(color: colorScheme.accent),
                      ),
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: TextField(
                              padding: const EdgeInsets.all(0),
                              border: false,
                              controller: titleController,
                              initialValue: "My Cool Password",
                              placeholder: Text("Password Title"),
                              maxLength: 26,
                              style: theme.typography.h4,
                            ),
                          ),
                          const Gap(20),
                          EmailPassword(
                            emailController: emailController,
                            passwordController: passwordController,
                            active: selected.contains(0),
                          ),
                          CreditCard(
                            hidden: false,
                            active: selected.contains(1),
                            cardNumberController: cardNumberController,
                            monthController: monthController,
                            cvcController: cvcController,
                          ),
                          Address(
                            obscure: false,
                            active: selected.contains(2),
                            addressLineController: addressLineController,
                            streetController: streetController,
                            postalController: postalController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        footers: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Button.primary(
              onPressed: selected.isEmpty
                  ? null
                  : () {
                      if ((selected.contains(0) &&
                              (emailController.text.isEmpty ||
                                  passwordController.text.isEmpty)) ||
                          (selected.contains(1) &&
                              (cardNumberController.text.isEmpty ||
                                  monthController.text.isEmpty ||
                                  cvcController.text.isEmpty)) ||
                          (selected.contains(2)) &&
                              (addressLineController.text.isEmpty ||
                                  streetController.text.isEmpty ||
                                  postalController.text.isEmpty)) {
                        showToastification('Please fill all the fields');
                      } else {
                        BlocProvider.of<PasswordsCubit>(context).createPassword(
                          PasswordEntity(
                            title: titleController.text,
                            username: emailController.text,
                            password: passwordController.text,
                            creditCardInfo: {
                              StringConst.cardNumber: cardNumberController.text,
                              StringConst.monthYear: monthController.text,
                              StringConst.cvc: cvcController.text,
                            },
                            otherFields: {
                              StringConst.addressLine1:
                                  addressLineController.text,
                              StringConst.street: streetController.text,
                              StringConst.postalCode: postalController.text,
                            },
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
              child: Text(
                "Create Password",
                style: TextStyle(
                  color: selected.isEmpty ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
