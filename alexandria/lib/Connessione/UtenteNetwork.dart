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
    print(serverResponse.statusCode);


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

    utente = Utente(username, nome, cognome, email, password);
    String json = jsonEncode(utente); //Linea di codice consigliato dalla documentazione ma, se messa nella post, non funziona. Linguaggio di merda
    
    getMapping = "/create";
    serverResponse = await post(Uri.parse(url+requestMapping+getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, dynamic> {
      'user_ID': utente.user_ID,
      'username': utente.username,
      'nome': utente.nome,
      'cognome': utente.cognome,
      'email': utente.email,
      'password_hashed': utente.password,
      'salt': utente.salt,}),);

    print(serverResponse.statusCode);
    if(serverResponse.statusCode == 200) {

      return login(utente.username, utente.password);
    } else {
      return null;
    }
  }

  Future<Utente?> getUtenteById(int user_id) async {
    getMapping = "/create/getUtenteById/"+user_id.toString();
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

  Future<List<Utente>?> findAll() async {
    late List<Utente> utenti = [];
    getMapping = "/create/findAll";
    serverResponse = await get(Uri.parse(url+requestMapping+getMapping));

    if(serverResponse.statusCode == 200) {
      List<dynamic> utentiJson = jsonDecode(serverResponse.body) as List<dynamic>;
      for(var utenteJson in utentiJson) {
        Utente u = Utente.fromJson(utenteJson as Map<String, dynamic>);
        utenti.add(u);
      }

      return utenti;
    }
    else {
      return null;
    }
  }

  Future<bool?> deleteUserFromId(int user_id) async {
    getMapping = "/delete/"+user_id.toString();

    serverResponse = await delete(Uri.parse(url+requestMapping+getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',}, );
    if(serverResponse.statusCode == 200) return true;
    else false;
  }

  Future<bool?> updateUser(Utente newUtente) async {
    getMapping = "/update";

    serverResponse = await put(Uri.parse(url+requestMapping+getMapping), headers: <String, String> { 'Content-Type': 'application/json; charset=UTF-8', },
      body: jsonEncode(<String, dynamic> {
        'user_ID': newUtente.user_ID,
        'username': newUtente.username,
        'nome': newUtente.nome,
        'cognome': newUtente.cognome,
        'password_hashed': newUtente.password,
        'salt': newUtente.salt,}), );
    if(serverResponse.statusCode == 200) return true;
    else return false;
  }

}