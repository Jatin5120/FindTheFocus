import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  /// This is default Constructor of [MyButton] class
  ///
  /// This returns a Primary Button
  ///
  /// The Other two Constructors are [MyButton.secondary] and [MyButton.outlined].
  MyButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.buttonSize = ButtonSize.medium,
    this.icon,
    this.isCTA = false,
    this.backgroundColor = kPrimaryColor,
    this.elevation = 10,
  }) : super(key: key);

  /// This is secondary Constructor of [MyButton] class
  ///
  /// This returns a Secondary Button
  ///
  /// The Other two Constructors are [MyButton](default Constructor) and [MyButton.outlined].
  MyButton.secondary({
    Key? key,
    required this.label,
    required this.onPressed,
    this.buttonSize = ButtonSize.medium,
    this.icon,
    this.isCTA = false,
    this.backgroundColor = kSecondaryColor,
    this.elevation = 10,
  }) : super(key: key) {
    _buttonType = ButtonType.secondary;
    _labelColor = kPrimaryColor;
  }

  /// This is outlined Constructor of [MyButton] class
  ///
  /// This returns a Outlined Button
  ///
  /// The Other two Constructors are [MyButton](default Constructor) and [MyButton.secondary].
  MyButton.outlined({
    Key? key,
    required this.label,
    required this.onPressed,
    this.buttonSize = ButtonSize.medium,
    this.icon,
    this.isCTA = false,
    this.backgroundColor = kPrimaryColor,
    this.elevation = 10,
  }) : super(key: key) {
    _buttonType = ButtonType.outlined;
    _labelColor = backgroundColor!;
    switch (buttonSize) {
      case ButtonSize.small:
        _outlinedWidth = kSmallBorderWidth;
        break;
      case ButtonSize.medium:
        _outlinedWidth = kMediumBorderWidth;
        break;
      case ButtonSize.large:
        _outlinedWidth = kLargeBorderWidth;
        break;
      default:
    }
  }

  /// if buttonSize is [ButtonSize.small], icon won't be displayed in the button
  final IconData? icon;

  /// The buttonSize of the button is to describe how big or how small the button will be
  ///
  /// buttonSize could be any of the the [enums].
  ///
  /// [ButtonSize.small], [ButtonSize.medium], [ButtonSize.large].
  final ButtonSize? buttonSize;
  final String? label;
  final VoidCallback? onPressed;
  final bool? isCTA;
  final Color? backgroundColor;
  final double? elevation;

  late double _spaceInBetween;
  late double _horizontalPadding;
  late double _verticalPadding;
  late TextStyle _labelStyle;
  late OutlinedBorder _buttonShape;

  ButtonType _buttonType = ButtonType.primary;
  Color _labelColor = kWhiteColor;
  double _outlinedWidth = 0;
  bool _showIcon = true;

  setValues({
    required TextStyle style,
    required double padding,
    required OutlinedBorder shape,
    double space = 0.0,
    bool? important = false,
  }) {
    _spaceInBetween = _showIcon ? space : 0;
    _labelStyle = style.copyWith(color: _labelColor);
    _horizontalPadding = important! ? padding * 3 : padding;
    _verticalPadding = padding / 3;
    _buttonShape = shape;
  }

  setSize(Size size) {
    if (isCTA! || icon == null) _showIcon = false;
    switch (buttonSize) {
      case ButtonSize.small:
        _showIcon = false;
        setValues(
          style: Get.textTheme.subtitle2!,
          padding: size.width / 30,
          shape: kSmallButtonShape,
        );
        break;
      case ButtonSize.medium:
        setValues(
          space: size.width / 50,
          style: Get.textTheme.headline6!,
          padding: size.width / 20,
          shape: kMediumButtonShape,
          important: isCTA,
        );
        break;
      case ButtonSize.large:
        setValues(
          space: size.width / 30,
          style: Get.textTheme.headline5!,
          padding: size.width / 10,
          shape: kLargeButtonShape,
          important: isCTA,
        );
        break;
      default:
        setValues(
          space: size.width / 30,
          style: Get.textTheme.headline6!,
          padding: size.width / 20,
          shape: kMediumButtonShape,
        );
    }
  }

  Widget _buildLabel() {
    return _BuildLabel(
      label: label,
      labelStyle: _labelStyle,
      spaceInBetween: _spaceInBetween,
      showIcon: _showIcon,
      icon: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = Utils.size(context);
    setSize(size);
    final EdgeInsets _buttonPadding = EdgeInsets.symmetric(
      horizontal: _horizontalPadding,
      vertical: _verticalPadding,
    );
    switch (_buttonType) {
      case ButtonType.primary:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: backgroundColor ?? kPrimaryColor,
            padding: _buttonPadding,
            shape: _buttonShape,
            elevation: elevation,
          ),
          onPressed: onPressed!,
          child: _buildLabel(),
        );
      case ButtonType.secondary:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: backgroundColor ?? kSecondaryColor,
            padding: _buttonPadding,
            shape: _buttonShape,
            elevation: elevation,
          ),
          onPressed: onPressed!,
          child: _buildLabel(),
        );
      default:
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: backgroundColor ?? kPrimaryColor,
              width: _outlinedWidth,
            ),
            primary: backgroundColor ?? kPrimaryColor,
            padding: _buttonPadding,
            shape: _buttonShape,
            elevation: 0,
          ),
          onPressed: onPressed!,
          child: _buildLabel(),
        );
    }
  }
}

class _BuildLabel extends StatelessWidget {
  const _BuildLabel({
    Key? key,
    required this.label,
    required TextStyle labelStyle,
    required double spaceInBetween,
    required bool showIcon,
    required this.icon,
  })  : _labelStyle = labelStyle,
        _spaceInBetween = spaceInBetween,
        _showIcon = showIcon,
        super(key: key);

  final String? label;
  final TextStyle _labelStyle;
  final double _spaceInBetween;
  final bool _showIcon;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label!, style: _labelStyle),
        SizedBox(width: _spaceInBetween),
        if (_showIcon && icon != null) Icon(icon)
      ],
    );
  }
}
