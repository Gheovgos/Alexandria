import 'package:alexandria/screens/animation_screen.dart';
import 'package:alexandria/screens/create_categoria_screen.dart';
import 'package:alexandria/screens/home_screen.dart';
import 'package:alexandria/screens/login_screen.dart';
import 'package:alexandria/screens/my_riferimenti_screen.dart';
import 'package:alexandria/screens/net_error_screen.dart';
import 'package:alexandria/screens/register_screen.dart';
import 'package:alexandria/screens/search_result_screen.dart';
import 'package:alexandria/screens/settings_screen.dart';
import 'package:alexandria/screens/view_categoria_screen.dart';
import 'package:alexandria/screens/view_riferimento_screen.dart';
import 'package:alexandria/screens/welcome_screen.dart';
import 'package:alexandria/screens/write_riferimento_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('it'),
      ],
      theme: ThemeData(fontFamily: 'Josefin Sans'),
      title: 'Alexandria',
      initialRoute: 'animation',
      routes: {
        'animation': (context) => const AnimationScreen(),
        'welcome': (context) => const WelcomeScreen(),
        'neterror': (context) => const NetErrorScreen(),
        'login': (context) => const LoginScreen(),
        'register': (context) => const RegisterScreen(),
        'home': (context) => const HomeScreen(),
        'settings': (context) => const SettingsScreen(),
        'results': (context) => const SearchResultScreen(),
        'create_categoria': (context) => const CreateCategoriaScreen(),
        'write_riferimento': (context) => const WriteRiferimentoScreen(),
        'my_riferimenti': (context) => const MyRiferimentiScreen(),
        'view_riferimento': (context) => const ViewRiferimentoScreen(),
        'view_categoria': (context) => const ViewCategoriaScreen()
      },
    ),
  );
}
