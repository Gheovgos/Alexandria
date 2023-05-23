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

import '../Connessione/ConnectionHandler.dart';
import '../Model/Utente.dart';
import '../Model/Riferimento.dart';
import '../Model/Categoria.dart';
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
  Utente cinzia = await conn.login("Heisenberg", "aptx4869") as Utente;
  Utente chiara = await conn.login("chiaretta boltzmann", "entropia") as Utente;
  Riferimento r = Riferimento(100, "Compasso", DateTime.now(), tipo_enum.Libro, "www.amazon.it", null, true, "La storia di un'amicizia sancita da un compasso", "Mondadori", "978 888 1921", "3777819", "Napoli", 0, 300, 1);
  /*Riferimento? r = await conn.createRiferimento("Il giallo di MSA", DateTime.now(), tipo_enum.Libro, null, 13033,
      false, "Ispirato dai più grandi romanzi di A. Conan Doyle, questo romanzo si ispira 
      ad avvenimenti realmente accaduti, con un po' di immaginazione, e nomi di fantasia.",
      "Feltrinelli", "9090000", "372920", "Napoli", 1, 300, 1) as Riferimento?;*/
  r = await conn.createRiferimento(r, await conn.createCategoria("Romanzo", chiara.user_ID, null) as Categoria, chiara.user_ID, null) as Riferimento;

  Riferimento u = await conn.getRiferimentoByNome("Il giallo di MSA") as Riferimento;
  u.pag_fine = 375;
  print(r.pag_fine);
  //if(await conn.aggiornaRiferimento(r) as bool == true) print((await conn.getRiferimentoByNome("Il giallo di MSA") as Riferimento).pag_fine);


}

