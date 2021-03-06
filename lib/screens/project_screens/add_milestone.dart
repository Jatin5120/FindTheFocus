// ignore_for_file: avoid_print

import 'package:find_the_focus/services/services.dart';

import '../../constants/constants.dart';
import '../../controllers/controllers.dart';
import '../../modals/modals.dart';
import '../../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMilestone extends StatelessWidget {
  const AddMilestone({Key? key}) : super(key: key);

  static TextEditingController milestonesController = TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: Utils.scaffoldPadding(size),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      projectController.projectName,
                      style: Get.textTheme.headline5,
                    ),
                    Text(
                      'Add Milestones',
                      style: Get.textTheme.headline4,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormLabelText(label: 'Milestones'),
                      Row(
                        children: [
                          _MilestoneField(milestonesController),
                          _AddButton(
                            milestonesController: milestonesController,
                            formKey: _formKey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                flex: 3,
                child: _MileStoneList(),
              ),
              Button(
                label: 'Finish',
                buttonSize: ButtonSize.large,
                onTap: () async {
                  await FirebaseService.addMilestones(
                      projectController.projectID);
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({
    required this.milestonesController,
    required this.formKey,
    Key? key,
  }) : super(key: key);

  final TextEditingController milestonesController;
  final GlobalKey<FormState> formKey;

  static ProjectController projectController = Get.find();
  static UserDataController userDataController = Get.find();

  addMilestone() {
    final String milestoneName = milestonesController.text;
    final Milestone milestone = Milestone(
      userID: userDataController.user!.uid,
      projectID: projectController.projectID,
      milestoneID: '',
      milestoneName: milestoneName,
      isCompleted: false,
      workingTimes: [],
      isUserWorking: false,
      totalWorked: 0,
      colorIndex: kGradientColors.uniqueValueIndex,
    );
    projectController.milestones.add(milestone);
    projectController.milestones.obs.refresh();
    Get.snackbar('', "'$milestoneName' Added to milestones");
    milestonesController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (formKey.currentState!.validate()) {
          addMilestone();
        }
      },
      child: Tooltip(
        message: 'Add Milestones to Project',
        child: Container(
          decoration: const BoxDecoration(
            color: kAccentColor,
            borderRadius: kLargeRadius,
          ),
          margin: EdgeInsets.only(left: size.width.twoDotFivePercent),
          padding: EdgeInsets.all(size.height.twoDotFivePercent),
          child: Text('Add', style: Get.textTheme.subtitle1),
        ),
      ),
    );
  }
}

class _MilestoneField extends StatelessWidget {
  const _MilestoneField(
    this.milestonesController, {
    Key? key,
  }) : super(key: key);

  final TextEditingController milestonesController;

  static ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
        controller: milestonesController,
        keyboardType: TextInputType.name,
        keyboardAppearance: Brightness.dark,
        style: Get.textTheme.subtitle1!.copyWith(color: kBlackColor),
        validator: (value) {
          final String? milestoneName = value;
          print("\n\n${'=' * 20} \n$milestoneName");
          if (milestoneName == null || milestoneName.isEmpty) {
            return "Milestone can't be empty";
          } else if (projectController.milestonesContains(milestoneName)) {
            Get.snackbar('', '$milestoneName is already present in Milestones');
            return 'Enter a different Value';
          } else {
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
    );
  }
}

class _MileStoneList extends StatelessWidget {
  const _MileStoneList({Key? key}) : super(key: key);

  static ProjectController projectController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.05),
      alignment: Alignment.center,
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemBuilder: (BuildContext context, int index) {
                            final String milestone =
                                controller.milestones[index].milestoneName;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                '??? $milestone',
                                style: Get.textTheme.subtitle1,
                              ),
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
