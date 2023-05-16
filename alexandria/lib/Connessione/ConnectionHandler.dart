import 'dart:convert';

import 'package:alexandria/Connessione/CategoriaNetwork.dart';
import 'package:alexandria/Connessione/RiferimentoNetwork.dart';
import 'package:http/http.dart';

import '../Model/Categoria.dart';
import '../Model/Utente.dart';
import '../Model/Riferimento.dart';
import 'UtenteNetwork.dart';
import 'CategoriaNetwork.dart';
import 'RiferimentoNetwork.dart';

class NetworkHelper {
  final String url = "http://192.168.1.199:8090";
  late UtenteNetwork _unet = UtenteNetwork(url);
  late CategoriaNetwork _catnet = CategoriaNetwork(url);
  late RiferimentoNetwork _rifnet = RiferimentoNetwork(url);

  NetworkHelper();

  Future<Utente?> login(String username, String password) async {
    return _unet.login(username, password);
  }

  Future<Utente?> registrazione(String username, String password, String nome, String cognome, String email) async {
    return _unet.registrazione(username, password, nome, cognome, email);
  }

  Future<Utente?> getUtenteById(int user_id) async {
    return _unet.getUtenteById(user_id);
  }

  Future<List<Utente>?> findAllUsers() async {
    return _unet.findAll();
  }

  Future<bool?> deleteUserFromId(int user_id) async {
    return _unet.deleteUserFromId(user_id);
  }

  Future<bool?> updateUser(Utente newUtente) async {
    return _unet.updateUser(newUtente);
  }

  Future<Categoria?> getCategoriaById(int categoriaID) async {
    return _catnet.getCategoriaById(categoriaID);
  }

  Future<List<Categoria>?> findAllCategories() async {
    return _catnet.findAll();
  }

  Future<Categoria?> findCategoriaByName(String nome) async {
    return _catnet.getCategoriaByName(nome);
  }

  Future<Categoria?> createCategoria(String nome, int user_id, int? superCategoria) async {
    return _catnet.creaCategoria(nome, user_id, superCategoria);
  }

  Future<bool?> updateCategoria(Categoria newCategoria) async {
    return _catnet.updateCategoria(newCategoria);
  }


}
