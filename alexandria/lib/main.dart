import 'package:alexandria/Connessione/ConnectionHandler.dart';
import 'package:alexandria/Model/Riferimento.dart';
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
import '../Model/tipo_enum.dart';

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

  Utente chiara = await conn.login("Heisenberg", "aptx4869") as Utente;
  Riferimento? r = await conn.createRiferimento("Il giallo di MSA", DateTime.now(), tipo_enum.Libro, null, 13033, false, "Ispirato dai più grandi romanzi di A. Conan Doyle, questo romanzo si ispira ad avvenimenti realmente accaduti, con un po' di immaginazione, e nomi di fantasia.", "Feltrinelli", "9090000", "372920", "Napoli", 1, 300, 1) as Riferimento?;

  List<Riferimento>? rif = await conn.getRiferimentoByUserId(1) as List<Riferimento>?;
  print(rif![0].titolo_riferimento);
  List<Riferimento> rif2 = await conn.getRiferimentoByUserId(chiara.user_ID) as List<Riferimento>;
  if(rif2.isEmpty) print(chiara.username+" non ha creato alcun riferimento");
  else print(rif2[0].titolo_riferimento);


}
