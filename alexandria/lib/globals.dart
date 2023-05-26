import 'package:alexandria/Connessione/ConnectionHandler.dart';
import 'package:alexandria/Model/Categoria.dart';
import 'package:alexandria/Model/Utente.dart';

Utente currentUser = Utente(
  1,
  'testUsername',
  'testName',
  'testLastName',
  'testEmail',
  'testPassword',
);
final NetworkHelper networkHelper = NetworkHelper();
late Future<List<Categoria>?> allCategories;
