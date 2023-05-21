import 'package:flutter/material.dart';

class MiniInfoBox extends StatelessWidget {
  const MiniInfoBox(
      {required this.name, super.key, this.fontSize, this.icon, this.onTap});
  final String name;
  final double? fontSize;
  final IconData? icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Material(
        elevation: 5,
        borderRadius: const BorderRadiusDirectional.all(Radius.circular(20)),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
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
                Text(
                  name,
                  style: TextStyle(fontSize: fontSize ?? 15),
                ),
                GestureDetector(
                  onTap: onTap ?? () {},
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
