// ignore_for_file: avoid_print

import 'package:find_the_focus/screens/projects/projects.dart';
import '../../controllers/controllers.dart';
import '../../constants/constants.dart';
import '../../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProject extends StatelessWidget {
  const AddProject({Key? key}) : super(key: key);

  static GlobalKey<FormState> projectFormKey = GlobalKey<FormState>();

  static ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      // onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: Utils.scaffoldPadding(size),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Add New Project',
                    style: Get.textTheme.headline4,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Form(
                    key: projectFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        _ProjectNameField(),
                        SizedBox(height: size.height.fivePercent),
                        _TargetDatePicker(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          MyButton.outlined(
                            label: 'Discard',
                            onPressed: () {
                              Get.back();
                              projectController.discardProject();
                            },
                            backgroundColor: kErrorColor,
                            isCTA: true,
                            buttonSize: ButtonSize.large,
                          ),
                          SizedBox(
                            height: size.height.twoPercent,
                          ),
                          LongButton(
                            label: 'Create',
                            onPressed: () async {
                              final bool isValid =
                                  projectFormKey.currentState!.validate();
                              if (isValid) {
                                Get.dialog(const _ConfirmationDialog());
                              }
                            },
                            isCTA: true,
                            buttonSize: ButtonSize.large,
                          ),
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
    );
  }
}

class _ConfirmationDialog extends StatelessWidget {
  const _ConfirmationDialog({Key? key}) : super(key: key);

  static ProjectsClient projectsClient = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Project'),
      content: const Text(
        "Are you sue to Add Project? You won't be able to change it later",
      ),
      backgroundColor: kBackgroundColor.shade300,
      titleTextStyle: Get.textTheme.headline6,
      contentTextStyle: Get.textTheme.subtitle1,
      elevation: kElevation,
      shape: kMediumShape,
      actions: [
        MyButton.secondary(
          label: 'Let me check',
          onPressed: () => Get.back(),
        ),
        MyButton(
          label: 'Yes, Create',
          onPressed: () async {
            Get.back();
            await projectsClient.createProject();
            Get.off(() => const AddMilestone());
          },
        ),
      ],
    );
  }
}

class _ProjectNameField extends StatelessWidget {
  _ProjectNameField({
    Key? key,
  }) : super(key: key);

  final ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabelText(label: 'Project Name'),
        TextFormField(
          keyboardType: TextInputType.name,
          keyboardAppearance: Brightness.dark,
          style: Get.textTheme.subtitle1!.copyWith(color: kBlackColor),
          validator: (name) {
            if (name!.isEmpty) {
              return "Project Name can't be Empty";
            }
            // if (name.isValidName()) return 'Enter a Valid Project Name';
            projectController.projectName = name;
            return null;
          },
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.badge_outlined,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _TargetDatePicker extends StatelessWidget {
  _TargetDatePicker({Key? key}) : super(key: key);

  final ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    final double padding = size.width.twoPercent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabelText(label: 'Target Date'),
        GestureDetector(
          onTap: () async {
            DateTime? date = await showDatePicker(
                context: context,
                initialDate: projectController.targetDate,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100));
            projectController.targetDate = date ?? projectController.targetDate;
          },
          child: Container(
            decoration: BoxDecoration(
              color: kBackgroundColor[300],
              borderRadius: kSmallRadius,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: size.width.fivePercent,
              vertical: size.height.onePercent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => Text(
                    projectController.displayeTargetDateMonth,
                    style: Get.textTheme.headline6,
                  ),
                ),
                SizedBox(
                  width: padding,
                ),
                const Icon(MyIcons.calender),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
