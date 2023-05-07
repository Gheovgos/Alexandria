import 'package:alexandria/Connessione/CategoriaNetwork.dart';
import 'package:alexandria/Connessione/RiferimentoNetwork.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'UtenteNetwork.dart';
import 'CategoriaNetwork.dart';
import 'RiferimentoNetwork.dart';

class NetworkHelper {
  final String url = "http://192.168.1.199:8090";
  late UtenteNetwork unet = UtenteNetwork(url);
  late CategoriaNetwork catnet = CategoriaNetwork(url);
  late RiferimentoNetwork rifnet = RiferimentoNetwork(url);
  late Response r;
  late String request;

  NetworkHelper();

  Future<dynamic> login(String username, String password) async {
    return unet.login(username, password);
  }
}
