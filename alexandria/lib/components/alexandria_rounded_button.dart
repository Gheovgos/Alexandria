import 'package:alexandria/constants.dart';
import 'package:flutter/material.dart';

class AlexandriaRoundedButton extends StatelessWidget {
  const AlexandriaRoundedButton({
    required this.child,
    super.key,
    this.onPressed,
    this.backgroundColor,
    this.padding,
    this.borderColor,
    this.border,
  });
  final OutlinedBorder? border;
  final Color? borderColor;
  final Color? backgroundColor;
  final void Function()? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        padding: padding,
        backgroundColor: backgroundColor ?? Colors.white,
        elevation: kButtonElevation,
        shape: border ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        side: BorderSide(color: borderColor ?? Colors.white),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
