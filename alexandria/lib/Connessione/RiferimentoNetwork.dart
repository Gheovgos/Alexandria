import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Model/Riferimento.dart';
import '../Model/tipo_enum.dart';

class RiferimentoNetwork {
  String url;
  String _requestMapping = "/api/v1/riferimento";
  late String _getMapping;
  late Response _serverResponse;
  late Riferimento _riferimento;
  late Map<String, dynamic> _riferimentoMap;
  RiferimentoNetwork(this.url);

  Future<Riferimento?> getRiferimentoById(int rif_id) async {
    _getMapping = "/get/getRiferimentoById/"+rif_id.toString();

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      _riferimentoMap = jsonDecode(_serverResponse.body) as Map<String, dynamic>;
      _riferimento = Riferimento.fromJson(_riferimentoMap);

      return _riferimento;
    }
    else return null;

  }
  
  Future<Riferimento?> getRiferimentoByNome(String titolo) async {
    _getMapping = "/get/getRiferimentoByNome/"+titolo;

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      _riferimentoMap = jsonDecode(_serverResponse.body) as Map<String, dynamic>;
      _riferimento = Riferimento.fromJson(_riferimentoMap);

      return _riferimento;
    }
    else return null;
  }

  Future<List<Riferimento>?> findAll() async {
    late List<Riferimento> riferimenti = [];
    _getMapping = "/get/findAll";
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var riferimentoJson in riferimentiJson) {
        Riferimento f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

      return riferimenti;
    }
    else return null;
  }

  Future<List<Riferimento>?> getRiferimentoByUserId(int userID) async {
    late List<Riferimento> riferimenti = [];
    _getMapping = "/get/getRiferimentoByUserId/"+userID.toString();


    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var riferimentoJson in riferimentiJson) {
        Riferimento f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

      return riferimenti;
    }
    else return null;

  }

  Future<Riferimento?> creaRiferimento(String titolo_riferimento, DateTime data_riferimento, tipo_enum tipo, String? URL, int? DOI, bool on_line, String? descr_riferimento,
      String? editore, String? isbn, String? isnn, String? luogo, int? pag_inizio, int? pag_fine, int? edizione, int userID) async {
    _getMapping = "/create/"+userID.toString();


    _serverResponse = await post(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, dynamic> {
      'id_Rif': 1000,
      'titolo': titolo_riferimento,
      'dataCreazione': DateUtils.dateOnly(data_riferimento).toString().substring(0, 10),
      'tipo': tipo.toString().substring(10),
      'url': URL                ,
      'doi': DOI,
      'digitale': on_line,
      'descrizione': descr_riferimento,
      'editore': editore,
      'isbn': isbn,
      'isnn': isnn,
      'luogo': luogo,
      'pag_inizio': pag_inizio,
      'pag_fine': pag_fine,
      'edizione': edizione,
    }),);

    if(_serverResponse.statusCode == 200) {
      return await getRiferimentoByNome(titolo_riferimento);
    } else return null;

  }

  Future<int?> _getNextId() async {
    _getMapping = "/getNextId";
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final id = int.parse(_serverResponse.body) + 1;

      return id;
    }
    else return null;
  }

}