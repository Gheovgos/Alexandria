import 'package:flutter/material.dart';

class MiniInfoBox extends StatelessWidget {
  const MiniInfoBox({super.key, required this.name,this.fontSize});
  final String name;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Material(
        elevation: 5,
        borderRadius: const BorderRadiusDirectional.all(Radius.circular(20)),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 20, top: 5, bottom: 5, end: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: fontSize??15),
                ),
                const Icon(Icons.info_outline)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
