import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  const CustomRaisedButton({
    Key? key,
    required this.buttonTitle,
    this.onPressedAction,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.fontSize,
    this.mode,
    required this.borderColor,
    required this.fontColor,
    this.iconColor,
    required this.fontWeight,
    this.icon,
    this.cardStyle,
  }) : super(key: key);

  final String buttonTitle;
  final VoidCallback? onPressedAction;
  final double width, height, borderRadius, fontSize;
  final String? mode;
  final Color borderColor, fontColor;
  final Color? iconColor;
  final FontWeight fontWeight;
  final IconData? icon;
  final String? cardStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
      width: MediaQuery.of(context).size.width * width,
      child: MaterialButton(
        elevation: 0,
        onPressed: onPressedAction,
        color: borderColor,
        shape: RoundedRectangleBorder(
          borderRadius: cardStyle == null
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius), bottomRight: Radius.circular(borderRadius)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(buttonTitle,
                style: TextStyle(
                  color: fontColor,
                  letterSpacing: 0.5,
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                )),
            if (icon != null)
              Icon(
                icon,
                color: iconColor,
              ),
          ],
        ),
      ),
    );
  }
}
