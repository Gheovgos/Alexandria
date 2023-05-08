import 'dart:convert';

import 'package:http/http.dart';

import '../Model/Utente.dart';

class UtenteNetwork {
  String url;
  String requestMapping = "/api/v1/utente";
  late String getMapping;
  late Response serverResponse;
  late Utente utente;
  late Map<String, dynamic> userMap;

  UtenteNetwork(this.url);

  Future<dynamic> login(String username, String password) async {
    getMapping = "/login/"+username+"/"+password;
    print(url+requestMapping+getMapping);
    serverResponse = await get(Uri.parse(url+requestMapping+getMapping));


    if(serverResponse.statusCode == 200) {
      userMap = jsonDecode(serverResponse.body);
      utente = Utente.fromJson(userMap);
      return utente;
    }
    else {
      return null;
    }
  }

  Future<dynamic> signup(String username, String password, String nome, String cognome, String email) async {
    getMapping = "/create";
    serverResponse = await post(Uri.parse(url+requestMapping+getMapping));
    if(serverResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}