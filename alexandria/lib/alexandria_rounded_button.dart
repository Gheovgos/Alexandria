import 'package:flutter/material.dart';

class AlexandriaRoundedButton extends StatelessWidget {
  AlexandriaRoundedButton(
      {super.key,
      required this.child,
      this.onPressed,
      this.backgroundColor,
      this.padding,
      this.elevation});
  double? elevation;
  Color? backgroundColor;
  void Function()? onPressed;
  Widget child;
  EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: padding,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
