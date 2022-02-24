import 'package:flutter/material.dart';
import 'package:ninja_way/constants.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor, loadingSpinnerColor;
  final double widthRatio;
  final bool isLoading;

  const SecondaryButton({
    required Key key,
    required this.text,
    required this.press,
    required this.widthRatio,
    this.isLoading = false,
    this.color = primaryColor,
    this.textColor = Colors.white,
    this.loadingSpinnerColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      key: UniqueKey(),
      text: text,
      press: press,
      widthRatio: widthRatio,
      color: primaryLightColor,
      textColor: Colors.black,
      loadingSpinnerColor: Colors.black,
    );
  }
}
