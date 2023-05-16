import 'package:alexandria/Connessione/ConnectionHandler.dart';
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

import 'Model/Categoria.dart';
import 'Model/Utente.dart';

void main() {
  NetworkHelper conn = NetworkHelper();
  foo(conn);
  runApp(MaterialApp(
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
      'write_riferimento' :(context) => const WriteRiferimentoScreen(),
      'my_riferimenti': (context) => const MyRiferimentiScreen(),
      'view_riferimento': (context) => const ViewRiferimentoScreen(),
      'view_categoria': (context) => const ViewCategoriaScreen()
    },
  ));

}
Future<void> foo(NetworkHelper conn) async {

  List<Categoria?> categorie = await conn.findAllCategories() as List<Categoria?>;
  for(int i = 0; i < categorie.length; i++) {
    print(categorie[i]?.id_categoria);
    print(categorie[i]?.nome);
    print(categorie[i]?.user_id);
    print(categorie[i]?.super_Categoria);
  }

}
