import 'dart:convert';

import 'package:alexandria/Connessione/CategoriaNetwork.dart';
import 'package:alexandria/Connessione/RiferimentoNetwork.dart';
import 'package:http/http.dart';

import '../Model/Utente.dart';
import 'CategoriaNetwork.dart';
import 'RiferimentoNetwork.dart';
import 'UtenteNetwork.dart';

class NetworkHelper {
  final String url = "http://192.168.1.199:8090";
  late UtenteNetwork unet = UtenteNetwork(url);
  late CategoriaNetwork catnet = CategoriaNetwork(url);
  late RiferimentoNetwork rifnet = RiferimentoNetwork(url);
  late Response r;
  late String request;

  NetworkHelper();

  Future<Utente?> login(String username, String password) async {
    return unet.login(username, password);
  }

  Future<Utente?> registrazione(String username, String password, String nome, String cognome, String email) async {
    return await unet.registrazione(username, password, nome, cognome, email);
  }

  Future<Utente?> getUtenteById(int user_id) async {
    return unet.getUtenteById(user_id);
  }

  Future<List<Utente>?> findAll() async {
    return unet.findAll();
  }

  Future<bool?> deleteUserFromId(int user_id) async {
    return unet.deleteUserFromId(user_id);
  }


}
