import 'package:find_the_focus/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../constants/constants.dart';

class DialogService {
  const DialogService._();

  /// This method shows a [Loading dialog] as an [Overlay] on the screen
  ///
  /// This uses `Get` library to show a `Dialog` with a `CircularProgressIndicator`
  ///
  /// This accepts only one parameter
  /// ```dart
  /// String title
  /// ```
  ///
  /// * To Close this dialog, use `closeDialog` method of the same `DialogService` class
  ///
  /// ```dart
  /// DialogService.closeDialog()
  /// ```
  static void showLoadingDialog(String message) {
    Get.dialog(
      Dialog(
        backgroundColor: kBackgroundColor[300],
        elevation: kElevation,
        shape: kLargeShape,
        insetPadding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
              ),
              const SizedBox(width: 15),
              Text(
                message,
                style: Get.textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// This method shows a [Confirmation dialog] as an [Overlay] on the screen
  ///
  /// This uses `Get` library to show a `Dialog` with [Action] buttons, you can use `Button` class for actions
  ///
  /// This accepts two required parameters
  /// ```dart
  /// String title;
  /// List<Widget> actions;
  /// ```
  /// And one optional parameter
  /// ```dart
  /// String description;
  /// ```
  ///
  /// * To Close this dialog, use `closeDialog` method of the same `DialogService` class
  ///
  /// ```dart
  /// DialogService.closeDialog()
  /// ```
  static void showConfirmationDialog(
      {required String title,
      String? description,
      required List<Widget> actions}) {
    Get.dialog(
      Dialog(
        backgroundColor: kBackgroundColor[300],
        elevation: kElevation,
        shape: kMediumShape,
        // insetPadding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headline6!.copyWith(color: kTextColor),
              ),
              if (description != null) ...[
                const SizedBox(height: 16),
                Text(
                  description,
                  style: Get.textTheme.subtitle1!
                      .copyWith(color: kTextColor.shade500),
                ),
              ],
              const SizedBox(height: 16),
              for (Widget action in actions) ...[
                const SizedBox(height: 4),
                SizedBox(
                  width: double.maxFinite,
                  child: action,
                ),
              ],
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// This method shows a [Error dialog] as an [Overlay] on the screen
  ///
  /// This uses `Get` library to show a `Dialog` with a the Error message
  ///
  /// And two optional named parameters
  /// ```dart
  /// String title
  /// String message
  /// ```
  /// which defaults to 'Error'
  ///
  /// * To Close this dialog, use `closeDialog` method of the same `DialogService` class
  ///
  /// ```dart
  /// DialogService.closeDialog()
  /// ```
  static void showSuccessDialog({
    String title = 'Success',
    String message = 'Done',
  }) {
    Get.dialog(
      Dialog(
        child: LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight.fortyPercent,
            width: constraints.maxWidth.eightyPercent,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0)
                      .copyWith(bottom: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Get.textTheme.headline6,
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: constraints.maxWidth.twentyPercent,
                          width: constraints.maxWidth.twentyPercent,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            border: Border.all(color: kSuccessColor, width: 3),
                          ),
                        ),
                        Icon(
                          Icons.done_rounded,
                          color: kSuccessColor,
                          size: constraints.maxWidth.tenPercent,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    message,
                    style: Get.textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
      barrierDismissible: false,
    );
  }

  /// This method shows a [Error dialog] as an [Overlay] on the screen
  ///
  /// This uses `Get` library to show a `Dialog` with a the Error message
  ///
  /// And two optional named parameters
  /// ```dart
  /// String title
  /// String message
  /// ```
  /// which defaults to 'Error'
  ///
  /// * To Close this dialog, use `closeDialog` method of the same `DialogService` class
  ///
  /// ```dart
  /// DialogService.closeDialog()
  /// ```
  static void showErrorDialog({
    String title = 'Error',
    String message = 'Something went wrong',
  }) {
    Get.dialog(
      AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        title: Text(
          title,
          style: Get.textTheme.headline6,
        ),
        content: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline_rounded, color: kPrimaryColor),
              const SizedBox(height: 16),
              Text(
                message,
                style: Get.textTheme.subtitle1,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        actions: const [
          Button(
            label: 'Ok',
            onTap: closeDialog,
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  /// This method shows a [Snackbar] at the top of the screen for a `Duration` of 3 seconds
  ///
  /// This uses `Get` library to show a `Snackbar` with a the title and message.
  ///
  /// This accepts two positional parameter
  /// ```dart
  /// String title
  /// String message
  /// ```
  /// And one optional named parameter
  /// ```dart
  /// DialogType dialogType
  /// ```
  /// which defaults to `DialogType.normal`
  ///
  /// Other possible values -
  /// * `DialogType.success`
  /// * `DialogType.warning`
  /// * `DialogType.error`
  ///
  /// The snakbar will automatically close after 3 seconds
  static void showSnackBar(
    String title,
    String message, {
    DialogType dialogType = DialogType.normal,
  }) {
    late Color backgroundColor;
    late IconData icon;

    switch (dialogType) {
      case DialogType.success:
        backgroundColor = kSuccessColor;
        icon = Icons.done_rounded;
        break;
      case DialogType.warning:
        backgroundColor = Colors.orange;
        icon = Icons.warning_amber_rounded;
        break;
      case DialogType.error:
        backgroundColor = kPrimaryColor;
        icon = Icons.error_outline_rounded;
        break;
      case DialogType.normal:
      default:
        backgroundColor = Colors.blue.shade700;
        icon = Icons.info_outline_rounded;
        break;
    }

    Get.snackbar(title, message,
        backgroundColor: backgroundColor,
        colorText: kWhiteColor,
        icon: Icon(icon, color: kWhiteColor));
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: kDividerColor.shade700,
      textColor: kBlackColor,
    );
  }

  static void closeDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
