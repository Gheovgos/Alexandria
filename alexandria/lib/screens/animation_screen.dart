import 'package:alexandria/constants.dart';
import 'package:alexandria/globals.dart';
import 'package:elliptic_text/elliptic_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      preferences = await SharedPreferences.getInstance();
      final username = preferences.getString('username');
      final password = preferences.getString('password');
      if (username != null && password != null) {
        final tempUser = await networkHelper.login(username, password);
        if (tempUser != null) {
          currentUser = tempUser;
          Navigator.pushNamed(context, 'home');
        } else {
          Navigator.pushNamed(context, 'welcome');
        }
      } else {
        Navigator.pushNamed(context, 'welcome');
      }
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
            alignment: Alignment.center,
            fit: StackFit.passthrough,
            children: [
              Hero(
                tag: 1,
                child: Center(
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
                height: 250,
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
