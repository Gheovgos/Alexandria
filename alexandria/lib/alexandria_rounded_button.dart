import 'package:flutter/material.dart';

class AlexandriaRoundedButton extends StatelessWidget {
  AlexandriaRoundedButton(
      {super.key,
      required this.child,
      this.onPressed,
      this.backgroundColor,
      this.padding,
      this.elevation,
      this.borderColor,
      this.border});
  OutlinedBorder? border;
  Color? borderColor;
  double? elevation;
  Color? backgroundColor;
  void Function()? onPressed;
  Widget child;
  EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        padding: padding,
        backgroundColor: backgroundColor??Colors.white,
        elevation: elevation,
        shape:
            border??RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        side:  BorderSide(color: borderColor??Colors.white)
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
