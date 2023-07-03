import 'dart:convert';

import 'package:http/http.dart';
import '../Model/Categoria.dart';

class CategoriaNetwork {
  String url;
  String _requestMapping = "/categoria";
  late String _getMapping;
  late Response _serverResponse;
  late Categoria _categoria;
  late Map<String, dynamic> _categoriaMap;
  CategoriaNetwork(this.url);

  Future<Categoria?> getCategoriaById(int categoriaID) async {
    _getMapping = "/get/getCategoriaById/"+categoriaID.toString();
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      _categoriaMap = jsonDecode(_serverResponse.body) as Map<String, dynamic>;
      _categoria = Categoria.fromJson(_categoriaMap);

      return _categoria;
    }
    else return null;
  }

  Future<List<Categoria>?> findAll() async {
    late List<Categoria> categorie = [];
    _getMapping = "/get/findAll";
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> categorieJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var categoriaJson in categorieJson) {
        Categoria c = Categoria.fromJson(categoriaJson as Map<String, dynamic>);
        categorie.add(c);
      }

      return categorie;
    }
    else return null;
  }

  Future<Categoria?> getCategoriaByName(String nome) async {
    _getMapping = "/get/getCategoriaByName/"+nome;
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      _categoriaMap = jsonDecode(_serverResponse.body) as Map<String, dynamic>;
      _categoria = Categoria.fromJson(_categoriaMap);

      return _categoria;
    }
    else return null;
  }

  Future<List<Categoria>?> getSopraCategorie(int? categoriaID) async {
    late List<Categoria> categorie = [];
    _getMapping = "/get/getSopraCategorie/"+categoriaID.toString();
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> categorieJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var categoriaJson in categorieJson) {
        Categoria c = Categoria.fromJson(categoriaJson as Map<String, dynamic>);
        categorie.add(c);
      }

      return categorie;
    }
    else return null;
  }

  Future<List<Categoria>?> getSottoCategorie(int? categoriaID) async {
    late List<Categoria> categorie = [];
    _getMapping = "/get/getSottoCategorie/"+categoriaID.toString();
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> categorieJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var categoriaJson in categorieJson) {
        Categoria c = Categoria.fromJson(categoriaJson as Map<String, dynamic>);
        categorie.add(c);
      }

      return categorie;
    }
    else return null;
  }



  Future<Categoria?> creaCategoria(String nome, int user_id, int? superCategoria) async {
    if(nome == "" || user_id < 0 || superCategoria! < 0) return null;
    final int id = await _getNextId() as int;
    _categoria = Categoria(id, nome, user_id, superCategoria);
    _getMapping = "/create/"+user_id.toString();
    _serverResponse = await post(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, dynamic> {
      'descr_categoria': _categoria.nome,
      'id_super_categoria': _categoria.super_Categoria,
      'id_utente': _categoria.user_id,
      'id_categoria': _categoria.id_categoria,}),);
    if(_serverResponse.statusCode == 200) {
      return _categoria;
    } else return null;

  }

  Future<bool> updateCategoria(Categoria newCategoria) async {
    _getMapping = "/update/"+newCategoria.user_id.toString();

    _serverResponse = await put(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String> { 'Content-Type': 'application/json; charset=UTF-8', },
      body: jsonEncode(<String, dynamic> {
        'descr_categoria': newCategoria.nome,
        'super_Categoria': newCategoria.super_Categoria,
        'id_utente': newCategoria.user_id,
        'id_categoria': newCategoria.id_categoria,}),);
    if(_serverResponse.statusCode == 200) return true;
    else return false;
  }

  Future<bool> deleteCategoriaById(Categoria c) async {
    _getMapping = "/delete";

    _serverResponse = await delete(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String> { 'Content-Type': 'application/json; charset=UTF-8', },
      body: jsonEncode(<String, dynamic> {
        'descr_categoria': c.nome,
        'super_Categoria': c.super_Categoria,
        'id_utente': c.user_id,
        'id_categoria': c.id_categoria,}),);
    if(_serverResponse.statusCode == 200) return true;
    else return false;
  }

  Future<List<Categoria>> getCategoriaByRiferimento(int id_riferimento) async {
    late List<Categoria> categorie = [];
    _getMapping = "/get/getCategoriaByRiferimento/"+id_riferimento.toString();
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var riferimentoJson in riferimentiJson) {
        Categoria f = Categoria.fromJson(riferimentoJson as Map<String, dynamic>);
        categorie.add(f);
      }

    }
    return categorie;

  }



  Future<int?> _getNextId() async {
    _getMapping = "/get/getNextId";
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final id = int.parse(_serverResponse.body) + 1;

      return id;
    }
    else return null;
  }

}