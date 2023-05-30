import 'package:alexandria/Connessione/ConnectionHandler.dart';
import 'package:alexandria/Model/Categoria.dart';
import 'package:alexandria/Model/Riferimento.dart';
import 'package:alexandria/Model/Utente.dart';
import 'package:shared_preferences/shared_preferences.dart';

Utente currentUser = Utente(
  1,
  'testUsername',
  'testName',
  'testLastName',
  'testEmail',
  'testPassword',
);
final NetworkHelper networkHelper = NetworkHelper();
Future<List<Categoria>?>? allCategories;
Future<List<Riferimento>?>? myRiferimenti;
Future<List<Riferimento>?>? allRiferimenti;
Future<List<Utente>?>? allUtenti;
late SharedPreferences preferences;
