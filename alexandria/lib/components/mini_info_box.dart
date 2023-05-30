import 'package:alexandria/constants.dart';
import 'package:flutter/material.dart';

class MiniInfoBox extends StatelessWidget {
  const MiniInfoBox({
    required this.name,
    super.key,
    this.fontSize,
    this.icon,
    this.onTap,
    this.onTapIcon,
    this.backgroundColor,
  });
  final String name;
  final double? fontSize;
  final IconData? icon;
  final void Function()? onTap;
  final void Function()? onTapIcon;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Material(
        elevation: kButtonElevation,
        borderRadius: const BorderRadiusDirectional.all(Radius.circular(20)),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: const BorderRadiusDirectional.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20,
              top: 5,
              bottom: 5,
              end: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onTap ?? () {},
                  child: SizedBox(
                    width: 150,
                    child: Text(
                      name,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: fontSize ?? 15,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onTapIcon ?? () {},
                  child: Icon(icon ?? Icons.info_outline),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
