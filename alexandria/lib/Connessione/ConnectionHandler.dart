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
import '../Model/tipo_enum.dart';

class NetworkHelper {
  final String url = "http://192.168.175.68:8090";
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

  Future<Categoria?> getCategoriaByName(String nome) async {
    return _catnet.getCategoriaByName(nome);
  }

  Future<Categoria?> getCategoriaByRiferimento(int id_riferimento) async {
    return _catnet.getCategoriaByRiferimento(id_riferimento);
  }

  Future<Categoria?> createCategoria(String nome, int user_id, int? superCategoria) async {
    return _catnet.creaCategoria(nome, user_id, superCategoria);
  }

  Future<bool?> updateCategoria(Categoria newCategoria) async {
    return _catnet.updateCategoria(newCategoria);
  }

  Future<bool?> deleteCategoria(Categoria c) async {
    return _catnet.deleteCategoriaById(c);
  }

  Future<Riferimento?> getRiferimentoById(int rif_id) async {
    return _rifnet.getRiferimentoById(rif_id);
  }

  Future<List<Riferimento>?> findAllRiferimenti() async {
    return _rifnet.findAll();
  }

  Future<List<Riferimento>?> getRiferimentoByUserId(int userID) async {
    return _rifnet.getRiferimentoByUserId(userID);
  }

  Future<Riferimento?> createRiferimento(String titolo_riferimento, DateTime data_riferimento, tipo_enum tipo, String? URL, int DOI, bool on_line, String descr_riferimento,
      String? editore, String? isbn, String? isnn, String? luogo, int? pag_inizio, int? pag_fine, int? edizione) async {
    return _rifnet.creaRiferimento(titolo_riferimento, data_riferimento, tipo, URL, DOI, on_line, descr_riferimento, editore, isbn, isnn, luogo, pag_inizio, pag_fine, edizione);
  }

  Future<Riferimento?> getRiferimentoByNome(String titolo) async {
    return _rifnet.getRiferimentoByNome(titolo);
  }


}
