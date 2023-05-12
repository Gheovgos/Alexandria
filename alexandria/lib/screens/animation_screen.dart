import 'package:alexandria/constants.dart';
import 'package:elliptic_text/elliptic_text.dart';
import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () async {
      Navigator.pushNamed(context, 'welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Center(
                child: Hero(
                  tag: 1,
                  child: SizedBox(
                    height: 300,
                    child: Column(
                      children: [
                        Image.asset('assets/launcher_icon.png'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 245,
                child: EllipticText(
                  perimiterAlignment: EllipticText_PerimiterAlignment.bottom,
                  centreAlignment: EllipticText_CentreAlignment.bottomSideAway,
                  text: 'ALEXANDRIA',
                  style: TextStyle(
                    color: kAlexandriaGreen,
                    fontSize: 30,
                    letterSpacing: 2,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
