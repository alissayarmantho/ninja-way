import 'package:flutter/material.dart';
import 'package:ninja_way/constants.dart';
import 'package:ninja_way/widgets/primary_button.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor, loadingSpinnerColor;
  final double widthRatio, marginLeft, marginRight, marginTop, marginBottom;
  final bool isLoading;

  const SecondaryButton({
    required Key key,
    required this.text,
    required this.press,
    required this.widthRatio,
    this.marginLeft = 10,
    this.marginRight = 10,
    this.marginTop = 10,
    this.marginBottom = 10,
    this.isLoading = false,
    this.color = primaryColor,
    this.textColor = Colors.white,
    this.loadingSpinnerColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      key: UniqueKey(),
      text: text,
      press: press,
      widthRatio: widthRatio,
      color: primaryLightColor,
      textColor: Colors.black,
      loadingSpinnerColor: Colors.black,
      marginBottom: marginBottom,
      marginLeft: marginLeft,
      marginRight: marginRight,
      marginTop: marginTop,
    );
  }
}
