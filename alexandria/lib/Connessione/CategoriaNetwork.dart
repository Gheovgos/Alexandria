import 'dart:convert';

import 'package:alexandria/Model/Categoria.dart';
import 'package:http/http.dart';

class CategoriaNetwork {
  CategoriaNetwork(this.url);
  String url;
  final String _requestMapping = '/categoria';
  late String _getMapping;
  late Response _serverResponse;
  late Categoria _categoria;
  late Map<String, dynamic> _categoriaMap;

  Future<Categoria?> getCategoriaById(int categoriaID) async {
    _getMapping = '/get/getCategoriaById/$categoriaID';
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      _categoriaMap = jsonDecode(_serverResponse.body) as Map<String, dynamic>;

      return Categoria.fromJson(_categoriaMap);
    }
    else {
      return null;
    }
  }

  Future<List<Categoria>?> findAll() async {
    late final categorie = <Categoria>[];
    _getMapping = '/get/findAll';
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final categorieJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final categoriaJson in categorieJson) {
        final c = Categoria.fromJson(categoriaJson as Map<String, dynamic>);
        categorie.add(c);
      }

      return categorie;
    }
    else {
      return null;
    }
  }

  Future<Categoria?> getCategoriaByName(String nome) async {
    _getMapping = '/get/getCategoriaByName/$nome';
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      _categoriaMap = jsonDecode(_serverResponse.body) as Map<String, dynamic>;

      return Categoria.fromJson(_categoriaMap);
    }
    else {
      return null;
    }
  }

  Future<List<Categoria>?> getSopraCategorie(int? categoriaID) async {
    late final categorie = <Categoria>[];
    _getMapping = '/get/getSopraCategorie/$categoriaID';
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final categorieJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final categoriaJson in categorieJson) {
        final c = Categoria.fromJson(categoriaJson as Map<String, dynamic>);
        categorie.add(c);
      }

      return categorie;
    }
    else {
      return null;
    }
  }

  Future<List<Categoria>?> getSottoCategorie(int? categoriaID) async {
    late final categorie = <Categoria>[];
    _getMapping = '/get/getSottoCategorie/$categoriaID';
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final categorieJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final categoriaJson in categorieJson) {
        final c = Categoria.fromJson(categoriaJson as Map<String, dynamic>);
        categorie.add(c);
      }

      return categorie;
    }
    else {
      return null;
    }
  }

  Future<Categoria?> creaCategoria(String nome, int user_id, int? superCategoria) async {
    if(nome == '' || user_id < 0 || superCategoria! < 0) return null;
    final id = await _getNextId();
    _categoria = Categoria(id!, nome, user_id, superCategoria);
    _getMapping = '/create/$user_id';
    _serverResponse = await post(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, dynamic> {
      'descr_categoria': _categoria.nome,
      'id_super_categoria': _categoria.super_Categoria,
      'id_utente': _categoria.user_id,
      'id_categoria': _categoria.id_categoria,}),);
    if(_serverResponse.statusCode == 200) {
      return _categoria;
    } else {
      return null;
    }

  }

  Future<bool> updateCategoria(Categoria newCategoria) async {
    _getMapping = '/update/${newCategoria.user_id}';

    _serverResponse = await put(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String> { 'Content-Type': 'application/json; charset=UTF-8', },
      body: jsonEncode(<String, dynamic> {
        'descr_categoria': newCategoria.nome,
        'super_Categoria': newCategoria.super_Categoria,
        'id_utente': newCategoria.user_id,
        'id_categoria': newCategoria.id_categoria,}),);
    if(_serverResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCategoriaById(Categoria c) async {
    _getMapping = '/delete';

    _serverResponse = await delete(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String> { 'Content-Type': 'application/json; charset=UTF-8', },
      body: jsonEncode(<String, dynamic> {
        'descr_categoria': c.nome,
        'super_Categoria': c.super_Categoria,
        'id_utente': c.user_id,
        'id_categoria': c.id_categoria,}),);
    if(_serverResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Categoria>> getCategoriaByRiferimento(int id_riferimento) async {
    late final categorie = <Categoria>[];
    _getMapping = '/get/getCategoriaByRiferimento/$id_riferimento';
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final riferimentoJson in riferimentiJson) {
        final f = Categoria.fromJson(riferimentoJson as Map<String, dynamic>);
        categorie.add(f);
      }

    }
    return categorie;

  }

  Future<int?> _getNextId() async {
    _getMapping = '/get/getNextId';
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
