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

  Future<Utente?> login(String username, String password) async {
    getMapping = "/login/"+username+"/"+password;
    print(url+requestMapping+getMapping);
    serverResponse = await get(Uri.parse(url+requestMapping+getMapping));


    if(serverResponse.statusCode == 200) {
      userMap = jsonDecode(serverResponse.body) as Map<String, dynamic>;
      utente = Utente.fromJson(userMap);
      return utente;
    }
    else {
      return null;
    }
  }

  Future<Utente?> registrazione(String username, String password, String nome, String cognome, String email) async {
    utente = Utente(100, username, nome, cognome, email, password, "randomSalt");
    String json = jsonEncode(utente);
    
    getMapping = "/create";
    print(url+requestMapping+getMapping);
    print(json);
    serverResponse = await post(Uri.parse(url+requestMapping+getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, dynamic> {
      'user_ID': utente.user_ID,
      'username': utente.username,
      'nome': utente.nome,
      'cognome': utente.cognome,
      'email': utente.email,
      'password': utente.password,
      'salt': utente.salt,}),);

    print(serverResponse.statusCode);
    if(serverResponse.statusCode == 200) {

      return utente;
    } else {
      return null;
    }
  }

}