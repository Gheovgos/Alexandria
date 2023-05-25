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
  final String url = "http://192.168.43.141:8090";
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

  Future<bool> deleteUserFromId(int user_id) async {
    return _unet.deleteUserFromId(user_id);
  }

  Future<bool> updateUser(Utente newUtente) async {
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

  Future<bool> updateCategoria(Categoria newCategoria) async {
    return _catnet.updateCategoria(newCategoria);
  }

  Future<bool> deleteCategoria(Categoria c) async {
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

  Future<Riferimento?> createRiferimento(Riferimento riferimento, Categoria categoria, int userID, Riferimento? rifCitanto) async {
    return _rifnet.creaRiferimento(riferimento, categoria, userID, rifCitanto);
  }

  Future<bool> aggiungiAutore(Riferimento riferimento, int autoreID) async {
    return _rifnet.aggiungiAutore(riferimento, autoreID);
  }

  Future<bool> aggiungiCategoria(Riferimento riferimento, int categoriaID) async {
    return _rifnet.aggiungiCategoria(riferimento, categoriaID);
  }

  Future<bool> aggiungiCitazione(Riferimento riferimento, int citanteID) async {
    return _rifnet.aggiungiCitazione(riferimento, citanteID);
  }

  Future<Riferimento?> getRiferimentoByNome(String titolo) async {
    return _rifnet.getRiferimentoByNome(titolo);
  }

  Future<bool> aggiornaRiferimento(Riferimento r) async {
    return _rifnet.aggiornaRiferimento(r);
  }

  Future<bool> aggiornaRiferimentoAutore(Riferimento riferimento, int oldAutoreID, int newAutoreID) async {
    return _rifnet.aggiornaRiferimentoAutore(riferimento, oldAutoreID, newAutoreID);
  }

  Future<bool> aggiornaRiferimentoCategoria(Riferimento riferimento, int oldCategoriaID, int newCategoriaID) async {
    return _rifnet.aggiornaRiferimentoCategoria(riferimento, oldCategoriaID, newCategoriaID);
  }

  Future<bool> aggiornaRiferimentoCitazione(Riferimento riferimento, int oldCitatoID, int newCitatoID) async {
    return _rifnet.aggiornaRiferimentoCitazione(riferimento, oldCitatoID, newCitatoID);
  }

  Future<List<Riferimento>?> getByRiferimentoAssociato(Riferimento riferimento) async {
    return _rifnet.getByRiferimentoAssociato(riferimento);
  }

  Future<List<Riferimento>?> getRiferimentoByAutore(String nome, String cognome) async {
    return _rifnet.getRiferimentoByAutore(nome, cognome);
  }

  Future<List<Riferimento>?> getRiferimentoByDOI(int DOI) async {
    return _rifnet.getRiferimentoByDOI(DOI);
  }

  Future<List<Riferimento>> getByDescrizione(String descrizione) async {
    return _rifnet.getByDescrizione(descrizione);
  }

  Future<List<Riferimento>> getCitazioniByUserId(int userID) async {
    return _rifnet.getCitazioniByUserId(userID);
  }

  Future<List<Riferimento>> getByTipo(tipo_enum tipo) async {
    return _rifnet.getByTipo(tipo);
  }

  Future<bool> deleteRiferimento(Riferimento r) async {
    return _rifnet.deleteRiferimento(r);
  }

  Future<bool> deleteRiferimentoAutore(Riferimento r, int autoreID) async {
    return _rifnet.deleteRiferimentoAutore(r, autoreID);
  }

  Future<bool> deleteRiferimentoCategoria(Riferimento r, int categoriaID) async {
    return _rifnet.deleteRiferimentoCategoria(r, categoriaID);
  }

  Future<bool> deleteRiferimentoCitazione(Riferimento r, int citazioneID) async {
    return _rifnet.deleteRiferimentoCitazione(r, citazioneID);
  }


}
