import 'package:alexandria/Connessione/ConnectionHandler.dart';
import 'package:alexandria/screens/create_category_screen.dart';
import 'package:alexandria/screens/login_screen.dart';
import 'package:alexandria/screens/net_error_screen.dart';
import 'package:alexandria/screens/register_screen.dart';
import 'package:alexandria/screens/search_result_screen.dart';
import 'package:alexandria/screens/settings_screen.dart';
import 'package:alexandria/screens/my_riferimenti_screen.dart';
import 'package:alexandria/screens/view_riferimento_screen.dart';
import 'package:alexandria/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  //NetworkHelper conn = NetworkHelper();
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Josefin Sans'),
    title: "Alexandria",
    initialRoute: 'welcome',
    routes: {
      'welcome': (context) => const WelcomeScreen(),
      'neterror': (context) => const NetErrorScreen(),
      'login': (context) => const LoginScreen(),
      'register': (context) => const RegisterScreen(),
      'home': (context) => const HomeScreen(),
      'settings': (context) => const SettingsScreen(),
      'results': (context) => const SearchResultScreen(),
      'create_category': (context) => const CreateCategoryScreen(),
      'my_riferimenti': (context) => const MyRiferimentiScreen(),
      'view_riferimento': (context) => const ViewRiferimentoScreen()
    },
  ));
}
