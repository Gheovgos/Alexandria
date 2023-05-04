import 'package:alexandria/constants.dart';
import 'package:flutter/cupertino.dart';

class AlexandriaContainer extends StatelessWidget {
  AlexandriaContainer({super.key, this.width, this.child});
  double? width;
  Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: kAlexandriaGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(120.0),
        ),
      ),
      child: child,
    );
  }
}