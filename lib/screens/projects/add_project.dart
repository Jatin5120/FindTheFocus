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
                  child: Container(
                    // color: MyColors.error,
                    child: Text(
                      'Add New Project',
                      style: Get.textTheme.headline4,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    // color: MyColors.accent,
                    child: Form(
                      key: projectFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ProjectNameField(),
                          MilestoneField(),
                          TargetDatePicker(),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    // color: MyColors.primary,
                    child: MileStoneList(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    // color: MyColors.success,
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
                              backgroundColor: MyColors.error,
                              isCTA: true,
                              buttonSize: ButtonSize.medium,
                            ),
                          ],
                        ),
                      ],
                    ),
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
        FormLabelText(label: 'Project Name'),
        TextFormField(
          keyboardType: TextInputType.name,
          keyboardAppearance: Brightness.dark,
          style: Get.textTheme.subtitle1!.copyWith(color: MyColors.black),
          validator: (name) {
            if (name?.length == 0 || name == null)
              return "Project Name can't be Empty";
            // if (name.isValidName()) return 'Enter a Valid Project Name';
            projectController.projectName = name;
            return null;
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.badge_outlined,
              color: MyColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class MilestoneField extends StatefulWidget {
  MilestoneField({
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
    projectController.milestones.forEach((milestone) =>
        matchValues.add(milestone.toLowerCase() == value.toLowerCase()));
    return matchValues.contains(true);
  }

  showSnackBar(String message, [bool isConfirmation = false]) {
    Widget content = isConfirmation
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(message), Icon(Icons.thumb_up_outlined)],
          )
        : Text(message);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: content));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabelText(label: 'Milestones'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: TextFormField(
                controller: milestonesController,
                keyboardType: TextInputType.name,
                keyboardAppearance: Brightness.dark,
                style: Get.textTheme.subtitle1!.copyWith(color: MyColors.black),
                validator: (value) {
                  final String? milestone = value;
                  print("\n\n${'=' * 20} \n$milestone");
                  if (milestone == null || milestone.isEmpty)
                    return null;
                  else if (milestonesContains(milestone)) {
                    showSnackBar('$milestone is already present in Milestones');
                    return 'Enter a different Value';
                  } else {
                    projectController.milestones.add(milestone);
                    projectController.milestones.obs.refresh();
                    showSnackBar("'$milestone' Added to milestones");
                    milestonesController.text = '';
                    return null;
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    MyIcons.task,
                    color: MyColors.primary,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final String milestone = milestonesController.text;
                print("\n\n${'=' * 20} \n$milestone");
                if (milestone.isEmpty)
                  showSnackBar('Enter a milestone to add.');
                else if (milestonesContains(milestone))
                  showSnackBar('$milestone is already present in Milestones');
                else {
                  projectController.milestones.add(milestone);
                  projectController.milestones.obs.refresh();
                  showSnackBar('$milestone Added');
                  milestonesController.text = '';
                }
              },
              child: Tooltip(
                message: 'Add Milestones to Project',
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.accent,
                    borderRadius: Utils.mediumRadius,
                  ),
                  margin: EdgeInsets.only(left: size.width * 0.025),
                  padding: EdgeInsets.all(size.width * 0.025),
                  child: Icon(MyIcons.plus),
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
                color: MyColors.subtitle,
                height: 1,
              ),
              children: [
                TextSpan(
                  text: 'Note: Enter each milestone separately. Press',
                ),
                TextSpan(
                  text: ' + ',
                  style: Get.textTheme.bodyText1!
                      .copyWith(color: MyColors.subtitle),
                ),
                TextSpan(
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
        FormLabelText(label: 'Target Date'),
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
              color: MyColors.background[300],
              borderRadius: Utils.smallRadius,
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
                Icon(MyIcons.calender),
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
        () => projectController.milestones.length == 0
            ? Text('No Milestones added for the project')
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
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.milestones.length,
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemBuilder: (BuildContext context, int index) {
                            final String milestone =
                                controller.milestones[index];
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
