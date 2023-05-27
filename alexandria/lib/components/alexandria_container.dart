import 'package:alexandria/constants.dart';
import 'package:flutter/cupertino.dart';

class AlexandriaContainer extends StatelessWidget {
  const AlexandriaContainer({super.key, this.width, this.child});
  final double? width;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: kAlexandriaGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(120),
        ),
      ),
      child: child,
    );
  }
}
