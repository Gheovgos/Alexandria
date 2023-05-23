import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Model/Categoria.dart';
import '../Model/Riferimento.dart';
import '../Model/tipo_enum.dart';

class RiferimentoNetwork {
  String url;
  final String _requestMapping = "/api/v1/riferimento";
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

  Future<List<Riferimento>?> getByRiferimentoAssociato(Riferimento riferimento) async {
    late List<Riferimento> riferimenti = [];
    _getMapping = "/get/getByRiferimento/"+riferimento.id_riferimento.toString();

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

  Future<List<Riferimento>?> getRiferimentoByAutore(String nome, String cognome) async {
    late List<Riferimento> riferimenti = [];
    _getMapping = "/get/getByAutoreSearch/"+nome+"/"+cognome;

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

  Future<List<Riferimento>?> getRiferimentoByDOI(int DOI) async {
    late List<Riferimento> riferimenti = [];
    _getMapping = "/get/getByDOISearch/"+DOI.toString();

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

  Future<Riferimento?> creaRiferimento(Riferimento riferimento, Categoria categoria, int userID, Riferimento? rifCitanto) async {
    if(rifCitanto == null) {
      _getMapping = "/create/"+userID.toString()+"/"+categoria.id_categoria.toString()+"/-1";
    } else _getMapping = "/create/"+userID.toString()+"/"+categoria.id_categoria.toString()+"/"+rifCitanto.id_riferimento.toString();



    _serverResponse = await post(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, dynamic> {
      'id_Rif': 1000, //placeholder
      'titolo': riferimento.titolo_riferimento,
      'dataCreazione': DateUtils.dateOnly(riferimento.data_riferimento).toString().substring(0, 10),
      'tipo': riferimento.tipo.toString().substring(10),
      'url': riferimento.URL,
      'doi': riferimento.DOI,
      'on_line': riferimento.on_line,
      'descrizione': riferimento.descr_riferimento,
      'editore': riferimento.editore,
      'isbn': riferimento.isbn,
      'isnn': riferimento.isnn,
      'luogo': riferimento.luogo,
      'pag_inizio': riferimento.pag_inizio,
      'pag_fine': riferimento.pag_fine,
      'edizione': riferimento.edizione,
    }),);

    print(_serverResponse.statusCode);
    if(_serverResponse.statusCode == 200) {
      return await getRiferimentoByNome(riferimento.titolo_riferimento);
    } else return null;

  }

  Future<bool?> aggiornaRiferimento(Riferimento riferimento) async {
    _getMapping = "/update";

    _serverResponse = await put(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, dynamic> {
      'id_Rif': riferimento.id_riferimento,
      'titolo': riferimento.titolo_riferimento,
      'dataCreazione': riferimento.data_riferimento.toString().substring(0, 10),
      'tipo': riferimento.tipo.toString().substring(10),
      'url': riferimento.URL,
      'doi': riferimento.DOI,
      'on_line': riferimento.on_line,
      'descrizione': riferimento.descr_riferimento,
      'editore': riferimento.editore,
      'isbn': riferimento.isbn,
      'isnn': riferimento.isnn,
      'luogo': riferimento.luogo,
      'pag_inizio': riferimento.pag_inizio,
      'pag_fine': riferimento.pag_fine,
      'edizione': riferimento.edizione,
    }),);

    if(_serverResponse.statusCode == 200) {
      return true;
    } else return false;
  }

  Future<bool?> aggiornaRiferimentoAutore(Riferimento riferimento, int oldAutoreID, int newAutoreID) async {
    _getMapping = "/update/riferimentoAutore/"+riferimento.id_riferimento.toString()+"/"+oldAutoreID.toString()+"/"+newAutoreID.toString();
    _serverResponse = await put(Uri.parse(url+_reques
        tMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      return true;
    } else return false;
  }

  Future<bool?> aggiornaRiferimentoCategoria(Riferimento riferimento, int oldCategoriaID, int newCategoriaID) async {
    _getMapping = "/update/riferimentoAutore/"+riferimento.id_riferimento.toString()+"/"+oldCategoriaID.toString()+"/"+newCategoriaID.toString();
    _serverResponse = await put(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      return true;
    } else return false;
  }

  Future<bool?> aggiornaRiferimentoCitazione(Riferimento riferimento, int oldCitatoID, int newCitatoID) async {
    _getMapping = "/update/riferimentoAutore/"+riferimento.id_riferimento.toString()+"/"+oldCitatoID.toString()+"/"+newCitatoID.toString();
    _serverResponse = await put(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      return true;
    } else return false;
  }


  Future<bool?> aggiungiAutore(Riferimento r, int autoreID) async {
    Riferimento? riferimento = await getRiferimentoByNome(r.titolo_riferimento) as Riferimento?;
      if(await riferimento != null) {
        _getMapping = "/create/aggiungiAutore/"+autoreID.toString();
        _serverResponse = await post(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
        }, body: jsonEncode(<String, dynamic> {
          'id_Rif': riferimento?.id_riferimento,
          'titolo': riferimento?.titolo_riferimento,
          'dataCreazione': riferimento?.data_riferimento.toString().substring(0, 10),
          'tipo': riferimento?.tipo.toString().substring(10),
          'url': riferimento?.URL,
          'doi': riferimento?.DOI,
          'on_line': riferimento?.on_line,
          'descrizione': riferimento?.descr_riferimento,
          'editore': riferimento?.editore,
          'isbn': riferimento?.isbn,
          'isnn': riferimento?.isnn,
          'luogo': riferimento?.luogo,
          'pag_inizio': riferimento?.pag_inizio,
          'pag_fine': riferimento?.pag_fine,
          'edizione': riferimento?.edizione,
        }),);

        if(_serverResponse.statusCode == 200) {
          return true;
        } else return false;
      } else return false;

  }

  Future<bool?> aggiungiCategoria(Riferimento r, int categoriaID) async {
    Riferimento? riferimento = await getRiferimentoByNome(r.titolo_riferimento) as Riferimento?;
    if(await riferimento != null) {
      _getMapping = "/create/aggiungiCategoria/"+categoriaID.toString();
      _serverResponse = await post(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
      }, body: jsonEncode(<String, dynamic> {
        'id_Rif': riferimento?.id_riferimento,
        'titolo': riferimento?.titolo_riferimento,
        'dataCreazione': riferimento?.data_riferimento.toString().substring(0, 10),
        'tipo': riferimento?.tipo.toString().substring(10),
        'url': riferimento?.URL,
        'doi': riferimento?.DOI,
        'on_line': riferimento?.on_line,
        'descrizione': riferimento?.descr_riferimento,
        'editore': riferimento?.editore,
        'isbn': riferimento?.isbn,
        'isnn': riferimento?.isnn,
        'luogo': riferimento?.luogo,
        'pag_inizio': riferimento?.pag_inizio,
        'pag_fine': riferimento?.pag_fine,
        'edizione': riferimento?.edizione,
      }),);

      if(_serverResponse.statusCode == 200) {
        return true;
      } else return false;
    } else return false;

  }

  Future<bool?> aggiungiCitazione(Riferimento citato, int citanteID) async {
    Riferimento? riferimento = await getRiferimentoByNome(citato.titolo_riferimento) as Riferimento?;
    if(await _riferimento != null) {
      _getMapping = "/create/aggiungiCitazione/"+citanteID.toString();
      _serverResponse = await post(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
      }, body: jsonEncode(<String, dynamic> {
        'id_Rif': riferimento?.id_riferimento,
        'titolo': riferimento?.titolo_riferimento,
        'dataCreazione': riferimento?.data_riferimento.toString().substring(0, 10),
        'tipo': riferimento?.tipo.toString().substring(10),
        'url': riferimento?.URL,
        'doi': riferimento?.DOI,
        'on_line': riferimento?.on_line,
        'descrizione': riferimento?.descr_riferimento,
        'editore': riferimento?.editore,
        'isbn': riferimento?.isbn,
        'isnn': riferimento?.isnn,
        'luogo': riferimento?.luogo,
        'pag_inizio': riferimento?.pag_inizio,
        'pag_fine': riferimento?.pag_fine,
        'edizione': riferimento?.edizione,
      }),);

      if(_serverResponse.statusCode == 200) {
        return true;
      } else return false;
    } else return false;

  }

}