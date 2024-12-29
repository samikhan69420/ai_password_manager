import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/ai/domain/entities/user_entity.dart';
import 'package:password_manager/features/ai/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:password_manager/features/app/const/classes_functions/toast.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  String? dateOfBirth;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.7,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  final UserEntity userEntity = state.userEntity;
                  dateOfBirth ?? (dateOfBirth = userEntity.dateOfBirth);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton.ghost(
                        icon: const Icon(RadixIcons.person),
                        size: const ButtonSize(2),
                        onPressed: () {},
                      ),
                      const Gap(20),
                      const Text("Your Profile").h4(),
                      const Gap(20),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                placeholder: Text("First Name"),
                                controller: firstNameController,
                                initialValue: userEntity.firstName,
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: TextField(
                                placeholder: Text("Last Name"),
                                controller: lastNameController,
                                initialValue: userEntity.lastName,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(10),
                      SizedBox(
                        width: double.infinity,
                        child: DatePicker(
                          value: DateTime.tryParse(dateOfBirth ?? ''),
                          placeholder: const Text("Date of birth"),
                          onChanged: (value) {
                            setState(() {
                              dateOfBirth = value.toString();
                            });
                          },
                        ),
                      ),
                      const Gap(10),
                      SizedBox(
                        width: double.infinity,
                        child: TextArea(
                          placeholder: Text("A little bit about yourself"),
                          expandableHeight: true,
                          controller: descController,
                          initialHeight: 100,
                          initialValue: userEntity.description,
                        ),
                      ),
                      const Gap(20),
                      SizedBox(
                        width: double.infinity,
                        child: Button.primary(
                          onPressed: () {
                            final String firstName = firstNameController.text;
                            final String lastName = lastNameController.text;
                            final String desc = descController.text;
                            if (firstName.isEmpty ||
                                lastName.isEmpty ||
                                desc.isEmpty) {
                              showToastification('Please fill all the fields');
                            } else {
                              BlocProvider.of<ProfileCubit>(context)
                                  .updateProfile(
                                UserEntity(
                                  dateOfBirth: dateOfBirth,
                                  description: descController.text,
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                ),
                              );
                            }
                          },
                          child: const Text("Save"),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Card(
                    padding: const EdgeInsets.all(35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.ghost(
                          icon: const Icon(RadixIcons.person),
                          size: const ButtonSize(2),
                          onPressed: () {},
                        ),
                        const Gap(20),
                        const Text("Your Profile").h4(),
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
                            value: DateTime.now(),
                            placeholder: const Text("Date of birth"),
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
                            onPressed: () {},
                            child: const Text("Save"),
                          ),
                        )
                      ],
                    ),
                  ).asSkeleton();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
