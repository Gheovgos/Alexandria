import 'package:alexandria/login_screen.dart';
import 'package:alexandria/register_screen.dart';
import 'package:alexandria/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(MaterialApp(
    title: "Alexandria",
    initialRoute: 'welcome',
    routes: {
      'welcome': (context) => const WelcomeScreen(),
      'login': (context) => const LoginScreen(),
      'register': (context) => const RegisterScreen(),
      'home': (context) => const HomeScreen()
    },
  ));
}
