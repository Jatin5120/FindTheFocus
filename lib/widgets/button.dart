import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:get/get.dart';

// // ignore: must_be_immutable
// class Button extends StatelessWidget {
//   /// This is default Constructor of [Button] class
//   ///
//   /// This returns a Primary Button
//   ///
//   /// The Other two Constructors are [Button.secondary] and [Button.outlined].
//   Button({
//     Key? key,
//     required this.label,
//     required this.onPressed,
//     this.buttonSize = ButtonSize.medium,
//     this.icon,
//     this.isCTA = false,
//     this.backgroundColor = kPrimaryColor,
//     this.elevation = 10,
//   }) : super(key: key);

//   /// This is secondary Constructor of [Button] class
//   ///
//   /// This returns a Secondary Button
//   ///
//   /// The Other two Constructors are [Button](default Constructor) and [Button.outlined].
//   Button.secondary({
//     Key? key,
//     required this.label,
//     required this.onPressed,
//     this.buttonSize = ButtonSize.medium,
//     this.icon,
//     this.isCTA = false,
//     this.backgroundColor = kSecondaryColor,
//     this.elevation = 10,
//   }) : super(key: key) {
//     _buttonType = ButtonType.secondary;
//     _labelColor = kPrimaryColor;
//   }

//   /// This is outlined Constructor of [Button] class
//   ///
//   /// This returns a Outlined Button
//   ///
//   /// The Other two Constructors are [Button](default Constructor) and [Button.secondary].
//   Button.outlined({
//     Key? key,
//     required this.label,
//     required this.onPressed,
//     this.buttonSize = ButtonSize.medium,
//     this.icon,
//     this.isCTA = false,
//     this.backgroundColor = kPrimaryColor,
//     this.elevation = 10,
//   }) : super(key: key) {
//     _buttonType = ButtonType.outlined;
//     _labelColor = backgroundColor!;
//     switch (buttonSize) {
//       case ButtonSize.small:
//         _outlinedWidth = kSmallShapeWidth;
//         break;
//       case ButtonSize.medium:
//         _outlinedWidth = kMediumShapeWidth;
//         break;
//       case ButtonSize.large:
//         _outlinedWidth = kLargeShapeWidth;
//         break;
//       default:
//     }
//   }

//   /// if buttonSize is [ButtonSize.small], icon won't be displayed in the button
//   final IconData? icon;

//   /// The buttonSize of the button is to describe how big or how small the button will be
//   ///
//   /// buttonSize could be any of the the [enums].
//   ///
//   /// [ButtonSize.small], [ButtonSize.medium], [ButtonSize.large].
//   final ButtonSize? buttonSize;
//   final String? label;
//   final VoidCallback? onPressed;
//   final bool? isCTA;
//   final Color? backgroundColor;
//   final double? elevation;

//   late double _spaceInBetween;
//   late double _horizontalPadding;
//   late double _verticalPadding;
//   late TextStyle _labelStyle;
//   late OutlinedBorder _buttonShape;

//   ButtonType _buttonType = ButtonType.primary;
//   Color _labelColor = kWhiteColor;
//   double _outlinedWidth = 0;
//   bool _showIcon = true;

//   setValues({
//     required TextStyle style,
//     required double padding,
//     required OutlinedBorder shape,
//     double space = 0.0,
//     bool? important = false,
//   }) {
//     _spaceInBetween = _showIcon ? space : 0;
//     _labelStyle = style.copyWith(color: _labelColor);
//     _horizontalPadding = important! ? padding * 3 : padding;
//     _verticalPadding = padding / 3;
//     _buttonShape = shape;
//   }

//   setSize(Size size) {
//     if (isCTA! || icon == null) _showIcon = false;
//     switch (buttonSize) {
//       case ButtonSize.small:
//         _showIcon = false;
//         setValues(
//           style: Get.textTheme.subtitle2!,
//           padding: size.width / 30,
//           shape: kSmallShape,
//         );
//         break;
//       case ButtonSize.medium:
//         setValues(
//           space: size.width / 50,
//           style: Get.textTheme.headline6!,
//           padding: size.width / 20,
//           shape: kMediumShape,
//           important: isCTA,
//         );
//         break;
//       case ButtonSize.large:
//         setValues(
//           space: size.width / 30,
//           style: Get.textTheme.headline5!,
//           padding: size.width / 10,
//           shape: kLargeShape,
//           important: isCTA,
//         );
//         break;
//       default:
//         setValues(
//           space: size.width / 30,
//           style: Get.textTheme.headline6!,
//           padding: size.width / 20,
//           shape: kMediumShape,
//         );
//     }
//   }

//   Widget _buildLabel() {
//     return _BuildLabel(
//       label: label,
//       labelStyle: _labelStyle,
//       spaceInBetween: _spaceInBetween,
//       showIcon: _showIcon,
//       icon: icon,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = Utils.size(context);
//     setSize(size);
//     final EdgeInsets _buttonPadding = EdgeInsets.symmetric(
//       horizontal: _horizontalPadding,
//       vertical: _verticalPadding,
//     );
//     switch (_buttonType) {
//       case ButtonType.primary:
//         return ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             primary: backgroundColor ?? kPrimaryColor,
//             padding: _buttonPadding,
//             shape: _buttonShape,
//             elevation: elevation,
//           ),
//           onPressed: onPressed!,
//           child: _buildLabel(),
//         );
//       case ButtonType.secondary:
//         return ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             primary: backgroundColor ?? kSecondaryColor,
//             padding: _buttonPadding,
//             shape: _buttonShape,
//             elevation: elevation,
//           ),
//           onPressed: onPressed!,
//           child: _buildLabel(),
//         );
//       default:
//         return OutlinedButton(
//           style: OutlinedButton.styleFrom(
//             side: BorderSide(
//               color: backgroundColor ?? kPrimaryColor,
//               width: _outlinedWidth,
//             ),
//             primary: backgroundColor ?? kPrimaryColor,
//             padding: _buttonPadding,
//             shape: _buttonShape,
//             elevation: 0,
//           ),
//           onPressed: onPressed!,
//           child: _buildLabel(),
//         );
//     }
//   }
// }

class Button extends StatelessWidget {
  ///It will return a Primary button, from `ElevatedButton` class
  ///
  ///
  ///If you want to make the button bigger in size pass in the optional parameter
  ///```dart
  ///ButtonSize buttonSize;
  ///```
  ///`ButtonSize` is an `enum` which has the following values
  ///[ButtonSize.small], [ButtonSize.medium], and [ButtonSize.large]
  ///
  ///[ButtonSize] deafults to [ButtonSize.small]
  ///
  ///Other Optional parameters are
  ///```dart
  ///Color buttonColor;
  ///Color labelColor;
  ///```
  ///
  ///
  ///Other two constructors are -
  ///
  ///* ```dart
  ///Button.secondary() // returns a Secondary Button
  ///```
  ///* ```dart
  ///Button.outlined()  // returns an Outlined Button
  ///```
  ///
  const Button({
    Key? key,
    required this.label,
    required this.onTap,
    this.buttonColor,
    this.labelColor,
    this.buttonSize = ButtonSize.small,
  })  : buttonType = ButtonType.primary,
        super(key: key);

  ///It will return a Secondary button, from `ElevatedButton` class
  ///
  ///
  ///If you want to make the button bigger in size pass in the optional parameter
  ///```dart
  ///ButtonSize buttonSize;
  ///```
  ///`ButtonSize` is an `enum` which has the following values
  ///[ButtonSize.small], [ButtonSize.medium], and [ButtonSize.large]
  ///
  ///[ButtonSize] deafults to [ButtonSize.small]
  ///
  ///Other Optional parameters are
  ///```dart
  ///Color buttonColor;
  ///Color labelColor;
  ///```
  ///
  ///
  ///Other two constructors are -
  ///
  ///* ```dart
  ///Button() // returns a Primary Button
  ///```
  ///* ```dart
  ///Button.outlined()  // returns an Outlined Button
  ///```
  ///
  const Button.secondary({
    Key? key,
    required this.label,
    required this.onTap,
    this.labelColor,
    this.buttonColor,
    this.buttonSize = ButtonSize.small,
  })  : buttonType = ButtonType.secondary,
        super(key: key);

  ///It will return an Outlined button, from `OutlinedButton` class
  ///
  ///
  ///If you want to make the button bigger in size pass in the optional parameter
  ///```dart
  ///ButtonSize buttonSize;
  ///```
  ///`ButtonSize` is an `enum` which has the following values
  ///[ButtonSize.small], [ButtonSize.medium], and [ButtonSize.large]
  ///
  ///[ButtonSize] deafults to [ButtonSize.small]
  ///
  ///Other Optional parameters are
  ///```dart
  ///Color buttonColor;
  ///Color labelColor;
  ///```
  ///
  ///
  ///Other two constructors are -
  ///
  ///* ```dart
  ///Button() // returns a Primary Button
  ///```
  ///* ```dart
  ///Button.secondary()  // returns a Secondary Button
  ///```
  ///
  const Button.outlined({
    Key? key,
    required this.label,
    required this.onTap,
    this.labelColor,
    this.buttonColor,
    this.buttonSize = ButtonSize.small,
  })  : buttonType = ButtonType.outlined,
        super(key: key);

  final String label;
  final VoidCallback onTap;

  ///It takes an `enum` `ButtonSize`, which will determine the size of the button,
  ///
  ///The possible values of the `enum` are -
  ///* `ButtonSize.small`
  ///* `ButtonSize.medium`
  ///* `ButtonSize.large`
  ///
  ///It defaults to [ButtonSize.small]
  final ButtonSize buttonSize;
  final Color? buttonColor;
  final Color? labelColor;
  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double? width;
    late EdgeInsets padding;
    late double fontSize;
    late OutlinedBorder border;
    late double outlineWidth;

    ///Configuring value like [padding, width, fontSize, & border]
    ///base on enum [ButtonSize] which can have values [ButtonSize.small],
    ///[ButtonSize.medium, ButtonSize.large]
    ///
    ///Default to [ButtonSize.small]

    switch (buttonSize) {
      case ButtonSize.small:
        width = null;
        padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);
        fontSize = 14;
        border = kSmallShape;
        outlineWidth = 1;
        break;

      case ButtonSize.medium:
        width = size.width.thirtyFivePercent;
        padding = const EdgeInsets.symmetric(vertical: 12.0);
        fontSize = 16;
        border = kMediumShape;
        outlineWidth = 1.5;
        break;

      case ButtonSize.large:
        width = double.maxFinite;
        padding = const EdgeInsets.symmetric(vertical: 16.0);
        fontSize = 20;
        border = kLargeShape;
        outlineWidth = 2;
        break;

      default:
        width = null;
        padding = const EdgeInsets.symmetric(vertical: 8.0);
        fontSize = 14;
        border = kSmallShape;
        outlineWidth = 1;
        break;
    }

    ///After configuring the values of [Button] based on [ButtonSize],
    ///[PrimaryButton, SecondaryButton or OutlinedButton] will be returned
    ///based on the property [ButtonType] which will be set by any of the three constructors
    ///
    ///[Button] - for [PrimaryButton], set [ButtonType] to [ButtonType.primary]
    ///[Button.secondary] - for [SecondaryButton], set [ButtonType] to [ButtonType.secondary]
    ///[Button.outlined] - for [OutlinedButton], set [ButtonType] to [ButtonType.outlined]

    switch (buttonType) {
      case ButtonType.primary:
        const Color _buttonColor = kPrimaryColor;
        const Color _lableColor = kTextColor;
        Widget button = ElevatedButton(
          onPressed: onTap,
          child: Text(
            label,
            style: Get.textTheme.button!.copyWith(
              color: labelColor ?? _lableColor,
              fontSize: fontSize,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: buttonColor ?? _buttonColor,
            padding: padding,
            shape: border,
          ),
        );
        if (width != null) {
          return SizedBox(
            width: width,
            child: button,
          );
        }
        return button;

      case ButtonType.secondary:
        Widget button = ElevatedButton(
          onPressed: onTap,
          child: Text(
            label,
            style: Get.textTheme.button!.copyWith(
              color: labelColor ?? kPrimaryColor,
              fontSize: fontSize,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: buttonColor ?? kSecondaryColor,
            padding: padding,
            shape: border,
          ),
        );
        if (width != null) {
          return SizedBox(
            width: width,
            child: button,
          );
        }
        return button;

      case ButtonType.outlined:
        const Color _buttonColor = kBackgroundColor;
        const Color _labelColor = kPrimaryColor;

        Widget button = OutlinedButton(
          onPressed: onTap,
          child: Text(label),
          style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith((states) => padding),
            shape: MaterialStateProperty.resolveWith((states) => border),
            textStyle: MaterialStateProperty.resolveWith(
              (state) => Get.textTheme.button!.copyWith(fontSize: fontSize),
            ),
            side: MaterialStateProperty.resolveWith(
              (states) => BorderSide(
                width: outlineWidth,
                color: buttonColor ?? _labelColor,
              ),
            ),
            overlayColor: MaterialStateProperty.resolveWith(
                (Set<MaterialState> buttonStates) {
              if (buttonStates.contains(MaterialState.pressed)) {
                return buttonColor ?? _labelColor;
              }
              return buttonColor ?? _buttonColor;
            }),
            foregroundColor: MaterialStateProperty.resolveWith(
                (Set<MaterialState> buttonStates) {
              if (buttonStates.contains(MaterialState.pressed)) {
                return _buttonColor;
              }
              return buttonColor ?? labelColor ?? _labelColor;
            }),
          ),
        );

        if (width != null) {
          return SizedBox(
            width: width,
            child: button,
          );
        }
        return button;

      default:
        const Color _buttonColor = kPrimaryColor;
        const Color _lableColor = kTextColor;
        Widget button = ElevatedButton(
          onPressed: onTap,
          child: Text(
            label,
            style: Get.textTheme.button!.copyWith(
              color: labelColor ?? _lableColor,
              fontSize: fontSize,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: buttonColor ?? _buttonColor,
            padding: padding,
            shape: border,
          ),
        );
        if (width != null) {
          return SizedBox(
            width: width,
            child: button,
          );
        }
        return button;
    }
  }
}
