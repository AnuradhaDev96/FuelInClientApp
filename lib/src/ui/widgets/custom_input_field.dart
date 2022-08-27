import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField(
      {Key? key,
      required this.borderRadius,
      required this.width,
      required this.height,
      required this.fontSize,
      required this.borderColor,
      required this.hintColor,
      this.onlyBorder,
      this.textColor,
      this.textEditingController,
      required this.icon,
      required this.hintText,
      required this.obsecureText,
      required this.iconColor})
      : super(key: key);

  final double borderRadius, width, height, fontSize;
  final Color borderColor, hintColor, iconColor;
  final Color? onlyBorder, textColor;
  final TextEditingController? textEditingController;
  final IconData icon;
  final String hintText;
  final bool obsecureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: onlyBorder ?? Colors.transparent),
        borderRadius: BorderRadius.circular(borderRadius),
        color: borderColor,
      ),
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * height,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            suffixIcon: Icon(
              icon,
              color: iconColor,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintColor,
              fontSize: fontSize,
            ),
            border: InputBorder.none),
        obscureText: obsecureText,
        style: TextStyle(
          color: textColor ?? hintColor,
        ),
      ),
    );
  }
}
