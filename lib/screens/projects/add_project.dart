// ignore_for_file: avoid_print

import 'dart:math';
import '../../modals/modals.dart';
import '../../controllers/controllers.dart';
import '../../constants/constants.dart';
import '../../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProject extends StatelessWidget {
  AddProject({Key? key}) : super(key: key);
  final GlobalKey<FormState> projectFormKey = GlobalKey<FormState>();
  final ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return GestureDetector(
      // onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
                  flex: 5,
                  child: Form(
                    key: projectFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ProjectNameField(),
                        const MilestoneField(),
                        TargetDatePicker(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: MileStoneList(),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          MyButton(
                            label: 'Create',
                            onPressed: () {
                              final bool isValid =
                                  projectFormKey.currentState!.validate();
                              if (isValid) {
                                projectController.createProject();
                                Get.back();
                              }
                            },
                            isCTA: true,
                            buttonSize: ButtonSize.large,
                          ),
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          MyButton.outlined(
                            label: 'Discard',
                            onPressed: () {
                              Get.back();
                              projectController.discardProject();
                            },
                            backgroundColor: kErrorColor,
                            isCTA: true,
                            buttonSize: ButtonSize.medium,
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

class ProjectNameField extends StatelessWidget {
  ProjectNameField({
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

class MilestoneField extends StatefulWidget {
  const MilestoneField({
    Key? key,
  }) : super(key: key);

  @override
  _MilestoneFieldState createState() => _MilestoneFieldState();
}

class _MilestoneFieldState extends State<MilestoneField> {
  final ProjectController projectController = Get.find();

  late TextEditingController milestonesController;

  @override
  void initState() {
    super.initState();
    milestonesController = TextEditingController();
  }

  bool milestonesContains(String value) {
    final List<bool> matchValues = [];
    for (var milestone in projectController.milestones) {
      matchValues
          .add(milestone.milestoneName!.toLowerCase() == value.toLowerCase());
    }
    return matchValues.contains(true);
  }

  showSnackBar(String message, [bool isConfirmation = false]) {
    Widget content = isConfirmation
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(message), const Icon(Icons.thumb_up_outlined)],
          )
        : Text(message);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: content));
  }

  int getColorIndex() {
    return Random().nextInt(kGraphColors.length);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabelText(label: 'Milestones'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: TextFormField(
                controller: milestonesController,
                keyboardType: TextInputType.name,
                keyboardAppearance: Brightness.dark,
                style: Get.textTheme.subtitle1!.copyWith(color: kBlackColor),
                validator: (value) {
                  final String? milestoneName = value;
                  print("\n\n${'=' * 20} \n$milestoneName");
                  if (milestoneName == null || milestoneName.isEmpty) {
                    return null;
                  } else if (milestonesContains(milestoneName)) {
                    showSnackBar(
                        '$milestoneName is already present in Milestones');
                    return 'Enter a different Value';
                  } else {
                    final Milestone milestone = Milestone(
                      milestoneName: milestoneName,
                      uniqueIndex: projectController.milestones.length,
                      colorIndex: getColorIndex(),
                    );
                    projectController.milestones.add(milestone);
                    projectController.milestones.obs.refresh();
                    showSnackBar("'$milestoneName' Added to milestones");
                    milestonesController.text = '';
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    MyIcons.task,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final String milestoneName = milestonesController.text;
                print("\n\n${'=' * 20} \n$milestoneName");
                if (milestoneName.isEmpty) {
                  showSnackBar('Enter a milestone to add.');
                } else if (milestonesContains(milestoneName)) {
                  showSnackBar(
                      '$milestoneName is already present in Milestones');
                } else {
                  final Milestone milestone = Milestone(
                    milestoneName: milestoneName,
                    uniqueIndex: projectController.milestones.length,
                    colorIndex: getColorIndex(),
                  );
                  projectController.milestones.add(milestone);
                  projectController.milestones.obs.refresh();
                  showSnackBar('$milestoneName Added');
                  milestonesController.text = '';
                }
              },
              child: Tooltip(
                message: 'Add Milestones to Project',
                child: Container(
                  decoration: const BoxDecoration(
                    color: kAccentColor,
                    borderRadius: kMediumRadius,
                  ),
                  margin: EdgeInsets.only(left: size.width * 0.025),
                  padding: EdgeInsets.all(size.width * 0.025),
                  child: const Icon(MyIcons.plus),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: size.width.twoPercent,
            top: size.height.onePercent,
          ),
          child: RichText(
            text: TextSpan(
              style: Get.textTheme.overline!.copyWith(
                color: kSubtitleColor,
                height: 1,
              ),
              children: [
                const TextSpan(
                  text: 'Note: Enter each milestone separately. Press',
                ),
                TextSpan(
                  text: ' + ',
                  style:
                      Get.textTheme.bodyText1!.copyWith(color: kSubtitleColor),
                ),
                const TextSpan(
                  text: 'to add Milestone.',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TargetDatePicker extends StatelessWidget {
  TargetDatePicker({Key? key}) : super(key: key);

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
                Obx(() => Text(
                      projectController.displayeTargetDate,
                      style: Get.textTheme.headline6,
                    )),
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

class MileStoneList extends StatelessWidget {
  MileStoneList({Key? key}) : super(key: key);

  final ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.05),
      child: Obx(
        () => projectController.milestones.isEmpty
            ? const Text('No Milestones added for the project')
            : Column(
                children: [
                  Text(
                    'Added Milestones',
                    style: Get.textTheme.bodyText1,
                  ),
                  GetX<ProjectController>(
                    builder: (controller) {
                      return Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.milestones.length,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemBuilder: (BuildContext context, int index) {
                            final String milestone =
                                controller.milestones[index].milestoneName!;
                            return Text(
                              '• $milestone',
                              style: Get.textTheme.subtitle1,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
