import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/features/ai/domain/entities/user_entity.dart';
import 'package:password_manager/features/ai/presentation/cubit/ai_cubit/ai_cubit.dart';
import 'package:password_manager/features/app/const/classes_functions/toast.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AiPasswordSheet extends StatefulWidget {
  final UserEntity userEntity;
  final TextEditingController passwordController;
  const AiPasswordSheet({
    super.key,
    required this.passwordController,
    required this.userEntity,
  });

  @override
  State<AiPasswordSheet> createState() => _AiPasswordSheetState();
}

class _AiPasswordSheetState extends State<AiPasswordSheet> {
  TextEditingController lengthController = TextEditingController();
  TextEditingController additionalParameters = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AiCubit, AiState>(
      listener: (context, state) {
        if (state is AiError) {
          showToastification(state.errorMsg ?? "Unexpected Error oaccured");
        }
        if (state is AiLoaded) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Basic(
                leading: const Icon(BootstrapIcons.stars).iconLarge(),
                title: const Text("Password").h4(),
              ),
              content: CodeSnippet(
                code: state.response,
                mode: 'shell',
              ),
              actions: [
                Button.outline(
                  child: const Text("Retry"),
                  onPressed: () {
                    Navigator.pop(context);
                    BlocProvider.of<AiCubit>(context).getAiPassword('''
                        First Name: ${widget.userEntity.firstName},
                        Last Name: ${widget.userEntity.lastName},
                        Date Of Birth: ${widget.userEntity.dateOfBirth},
                        Brief Description: ${widget.userEntity.description},
                        Memorability to Secureness scale: 5,
                        Additional Parameters for password provided by user (IGNORE IF EMPTY): ${additionalParameters.text}
                        Password Length: ${lengthController.text}
                      ''');
                  },
                ),
                Button.primary(
                  child: const Text("Use"),
                  onPressed: () {
                    Navigator.pop(context);
                    closeDrawer(context);
                    widget.passwordController.value =
                        TextEditingValue(text: state.response.trim());
                  },
                ),
              ],
            ),
          );
        }
      },
      child: BlocBuilder<AiCubit, AiState>(
        builder: (context, state) {
          if (state is AiLoaded) {
            return BodyWidget(
              additionalParameters: additionalParameters,
              userEntity: widget.userEntity,
              lengthController: lengthController,
            );
          } else if (state is AiLoading) {
            return BodyWidget(
              additionalParameters: additionalParameters,
              userEntity: widget.userEntity,
              lengthController: lengthController,
            ).asSkeleton();
          } else {
            return BodyWidget(
              additionalParameters: additionalParameters,
              userEntity: widget.userEntity,
              lengthController: lengthController,
            );
          }
        },
      ),
    );
  }
}

class BodyWidget extends StatefulWidget {
  final UserEntity userEntity;
  final TextEditingController lengthController;
  final TextEditingController additionalParameters;
  const BodyWidget({
    super.key,
    required this.lengthController,
    required this.userEntity,
    required this.additionalParameters,
  });

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  SliderValue sliderValue = const SliderValue.single(.5);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Gap(50),
          Icon(
            BootstrapIcons.stars,
            size: Theme.of(context).iconTheme.x4Large.size,
          ),
          const Gap(50),
          const Text(
            "Generate an AI password",
            style: TextStyle(
              fontSize: 20,
            ),
          ).mono(),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextArea(
              placeholder: "Additional parameters...",
              border: true,
              expandableHeight: true,
              controller: widget.additionalParameters,
              initialHeight: 150,
              borderRadius: Theme.of(context).borderRadiusLg,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              borderRadius: 20,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text('Easy to remember'),
                      Spacer(),
                      Text('More Secure'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Slider(
                      value: sliderValue,
                      divisions: 9,
                      onChanged: (value) {
                        setState(() {
                          sliderValue = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: NumberInput(
              controller: widget.lengthController,
              allowDecimals: false,
              initialValue: 8,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: PrimaryButton(
                child: const Text("Done"),
                onPressed: () {
                  BlocProvider.of<AiCubit>(context).getAiPassword('''
                        First Name: ${widget.userEntity.firstName},
                        Last Name: ${widget.userEntity.lastName},
                        Date Of Birth: ${widget.userEntity.dateOfBirth},
                        Brief Description: ${widget.userEntity.description},
                        Memorability to Secureness scale: ${sliderValue.value},
                        Additional Parameters: ${widget.additionalParameters.text}
                        Password Length: ${widget.lengthController.text}
                      ''');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}