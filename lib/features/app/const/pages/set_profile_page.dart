import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/ai/domain/entities/user_entity.dart';
import 'package:password_manager/features/ai/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:password_manager/features/app/const/classes_functions/toast.dart';
import 'package:password_manager/features/passwords/presentation/pages/password_pages/passwords_page.dart';
import 'package:password_manager/main_injection_container.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetProfilePage extends StatefulWidget {
  const SetProfilePage({super.key});

  @override
  State<SetProfilePage> createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  final SharedPreferences preferences = sl();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  DateTime? dateOfBirth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(35),
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.border),
                  borderRadius: theme.borderRadiusMd,
                  color: colorScheme.background,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Basic(
                      leading: Icon(
                        RadixIcons.person,
                        size: theme.iconTheme.x2Large.size,
                      ),
                      leadingAlignment: Alignment.center,
                      title: const Text("Lets start with a profile"),
                      subtitle:
                          const Text("This information will be stored locally"),
                    ),
                    const Gap(20),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              placeholder: Text("First Name"),
                              controller: firstNameController,
                            ),
                          ),
                          const Gap(10),
                          Expanded(
                            child: TextField(
                              placeholder: Text("Last Name"),
                              controller: lastNameController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    SizedBox(
                      width: double.infinity,
                      child: DatePicker(
                        value: dateOfBirth,
                        placeholder: const Text("Date of birth"),
                        onChanged: (value) {
                          setState(() {
                            dateOfBirth = value;
                          });
                        },
                      ),
                    ),
                    const Gap(10),
                    TextArea(
                      placeholder: Text("A little bit about yourself"),
                      expandableHeight: true,
                      controller: descController,
                      initialHeight: 100,
                    ),
                    const Gap(20),
                    SizedBox(
                      width: double.infinity,
                      child: Button.primary(
                        onPressed: () {
                          if (firstNameController.text.isEmpty ||
                              lastNameController.text.isEmpty ||
                              dateOfBirth == null ||
                              descController.text.isEmpty) {
                            showToastification("Please fill all the fields");
                          } else {
                            final UserEntity userEntitye = UserEntity(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              dateOfBirth: dateOfBirth.toString(),
                              description: descController.text,
                            );
                            BlocProvider.of<ProfileCubit>(context)
                                .setProfile(userEntitye);
                            preferences.setBool('firstTime', false);
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const PasswordsPage(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        child: const Text("Next"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
