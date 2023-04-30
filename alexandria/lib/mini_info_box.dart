import 'package:flutter/material.dart';

class MiniInfoBox extends StatelessWidget {
  MiniInfoBox({super.key, required this.name});
  String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsetsDirectional.only(
          start: 20, top: 5, bottom: 5, end: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.all(
            Radius.circular(20),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 15),
          ),
          const Icon(Icons.info_outline)
        ],
      ),
    );
  }
}