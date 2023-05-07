import 'package:http/http.dart';
import 'dart:convert';

class UtenteNetwork {
  String url;
  String requestMapping = "/api/v1/utente";
  late String getMapping;
  late Response serverResponse;
  UtenteNetwork(this.url);

  Future<dynamic> login(String username, String password) async {
    getMapping = "/create"; //placeholder. Credo che Claudio debba ancora implementare la funzione di login
    print(url+requestMapping+getMapping);
    serverResponse = await get(Uri.parse(url+requestMapping+getMapping));

    if(serverResponse.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }

  Future<dynamic> signup(String username, String password, String nome, String cognome, String email) async {
    return null;
  }

}