import 'dart:convert';

import 'package:alexandria/Model/Utente.dart';
import 'package:http/http.dart';

class UtenteNetwork {

  UtenteNetwork(this.url);
  String url;
  final String _requestMapping = '/api/v1/utente';
  late String _getMapping;
  late Response _serverResponse;
  late Utente _utente;
  late Map<String, dynamic> _userMap;

  Future<Utente?> login(String username, String password) async {
    _getMapping = '/login/$username/$password';
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      _userMap = jsonDecode(_serverResponse.body) as Map<String, dynamic>;
      return Utente.fromJson(_userMap);
    }
    else {
      return null;
    }
  }

  Future<Utente?> registrazione(String username, String password, String nome, String cognome, String email) async {
    final id = await _getNextId();
    _utente = Utente(id!, username, nome, cognome, email, password);

    _getMapping = '/create';
    _serverResponse = await post(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, dynamic> {
      'user_ID': _utente.user_ID,
      'username': _utente.username,
      'nome': _utente.nome,
      'cognome': _utente.cognome,
      'email': _utente.email,
      'password_hashed': _utente.password,
      'salt': _utente.salt,}),);

    if(_serverResponse.statusCode == 200) {

      return login(_utente.username, _utente.password);
    } else {
      return null;
    }
  }

  Future<Utente?> getUtenteById(int user_id) async {
    _getMapping = '/create/getUtenteById/$user_id';
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      _userMap = jsonDecode(_serverResponse.body) as Map<String, dynamic>;
      return Utente.fromJson(_userMap);
    }
    else {
      return null;
    }
  }

  Future<List<Utente>?> findAll() async {
    late final utenti = <Utente>[];
    _getMapping = '/create/findAll';
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final utentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final utenteJson in utentiJson) {
        final u = Utente.fromJson(utenteJson as Map<String, dynamic>);
        utenti.add(u);
      }

      return utenti;
    }
    else {
      return null;
    }
  }

  Future<List<Utente>?> getAutoriByRiferimento(int riferimentoID) async {
    late final utenti = <Utente>[];
    _getMapping = '/create/getAutoriByRiferimento/$riferimentoID';
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final utentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final utenteJson in utentiJson) {
        final u = Utente.fromJson(utenteJson as Map<String, dynamic>);
        utenti.add(u);
      }

      return utenti;
    }
    else {
      return null;
    }
  }

  Future<bool> deleteUserFromId(int user_id) async {
    _getMapping = '/delete/$user_id';

    _serverResponse = await delete(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',}, );
    if(_serverResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateUser(Utente newUtente) async {
    _getMapping = '/update';

    _serverResponse = await put(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String> { 'Content-Type': 'application/json; charset=UTF-8', },
      body: jsonEncode(<String, dynamic> {
        'user_ID': newUtente.user_ID,
        'username': newUtente.username,
        'nome': newUtente.nome,
        'cognome': newUtente.cognome,
        'email': newUtente.email,
        'password_hashed': newUtente.password,
        'salt': (await getUtenteById(newUtente.user_ID))?.salt}), );
    if(_serverResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<int?> _getNextId() async {
    _getMapping = '/create/getNextId';
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final id = int.parse(_serverResponse.body) + 1;

      return id;
    }
    else {
      return null;
    }
  }

}
