import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Model/Categoria.dart';
import '../Model/Riferimento.dart';
import '../Model/Utente.dart';
import '../Model/tipo_enum.dart';

class RiferimentoNetwork {
  String url;
  final String _requestMapping = "/api/v1/riferimento";
  late String _getMapping;
  late Response _serverResponse;
  late Riferimento _riferimento;
  late Map<String, dynamic> _riferimentoMap;
  RiferimentoNetwork(this.url);

  Future<List<Riferimento>> ricerca(String? titolo, int? doi, String? autore, List<Categoria>? categoria, List<tipo_enum> tipo) async {
    late List<Riferimento> riferimenti = [];
    late List<Riferimento> riferimentiCategoria = [];
    late List<Riferimento> riferimentiTipo = [];

    //Ricerca per titolo
    if(titolo != null && doi == null && autore == null) {
      riferimenti = await getRiferimentoBySTitolo(titolo) as List<Riferimento>;

      if(categoria != null)  {
        for(Categoria c in categoria) riferimentiCategoria += await getRiferimentoByCategoria(c.id_categoria) as List<Riferimento>;
        riferimenti = _filterList(riferimenti, riferimentiCategoria);
      }
      for(tipo_enum t in tipo) riferimentiTipo += await getByTipo(t) as List<Riferimento>;

      return _filterList(riferimenti, riferimentiTipo);
    }

    //Ricerca per DOI
    if(titolo == null && doi != null && autore == null) {
      riferimenti = await getRiferimentoByDOI(doi) as List<Riferimento>;

      if(categoria != null)  {
        for(Categoria c in categoria) riferimentiCategoria += await getRiferimentoByCategoria(c.id_categoria) as List<Riferimento>;
        riferimenti = _filterList(riferimenti, riferimentiCategoria);
      }
      for(tipo_enum t in tipo) riferimentiTipo += await getByTipo(t) as List<Riferimento>;

      return _filterList(riferimenti, riferimentiTipo);
    }
    
    if(titolo == null && doi == null && autore != null) {
      riferimenti = await getRiferimentoByAutore(autore) as List<Riferimento>;

      if(categoria != null)  {
        for(Categoria c in categoria) riferimentiCategoria += await getRiferimentoByCategoria(c.id_categoria) as List<Riferimento>;
        riferimenti = _filterList(riferimenti, riferimentiCategoria);
      }
      for(tipo_enum t in tipo) riferimentiTipo += await getByTipo(t) as List<Riferimento>;

      return _filterList(riferimenti, riferimentiTipo);
    }

    if(titolo == null && doi == null && autore == null)
      print("ERROR: Nessun parametro inserito per la ricerca di un riferimento. Ritorno lista vuota");

      return riferimenti;
  }

  List<Riferimento> _filterList(List<Riferimento> primaLista, List<Riferimento> secondaLista) {
    List<Riferimento> result = [];

    for(Riferimento primo in primaLista) {
      for(Riferimento secondo in secondaLista) {

        if(primo.id_riferimento == secondo.id_riferimento)
          result.add(primo);
      }
    }

    return result;
  }

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

  Future<List<Riferimento>> findAll() async {
    late List<Riferimento> riferimenti = [];
    _getMapping = "/get/findAll";
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var riferimentoJson in riferimentiJson) {
        Riferimento f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;
  }

  Future<List<Riferimento>> getRiferimentoByUserId(int userID) async {
    late List<Riferimento> riferimenti = [];
    _getMapping = "/get/getRiferimentoByUserId/"+userID.toString();


    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var riferimentoJson in riferimentiJson) {
        Riferimento f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;

  }


  //Dato un riferimento, vengono restituiti tutti i riferimenti che tale riferimento cita.

  Future<List<Riferimento>> getRiferimentiCitati(Riferimento riferimento) async {
    late List<Riferimento> riferimenti = [];
    _getMapping = "/get/getByRiferimento/"+riferimento.id_riferimento.toString();

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var riferimentoJson in riferimentiJson) {
        Riferimento f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;
  }


  //Dato un riferimento, vengono restituiti tutti i riferimenti che citano tale riferimento

  Future<List<Riferimento>> getRiferimentiCitanti(Riferimento riferimento) async {
    late List<Riferimento> riferimenti = [];
    _getMapping = "/get/getRiferimentiCitanti/"+riferimento.id_riferimento.toString();

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var riferimentoJson in riferimentiJson) {
        Riferimento f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;
  }

  Future<List<Riferimento>> getRiferimentoByAutore(String testo) async {
    late List<Riferimento> riferimenti = [];
    _getMapping = "/get/getByAutoreSearch/"+testo;

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var riferimentoJson in riferimentiJson) {
        Riferimento f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;

  }

  Future<List<Riferimento>> getRiferimentoByCategoria(int categoriaID) async {
    late List<Riferimento> riferimenti = [];
    _getMapping = "/get/getByCategoria/"+categoriaID.toString();

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var riferimentoJson in riferimentiJson) {
        Riferimento f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;

  }

  Future<List<Riferimento>> getRiferimentoByDOI(int DOI) async {
    late List<Riferimento> riferimenti = [];
    _getMapping = "/get/getByDOISearch/"+DOI.toString();

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var riferimentoJson in riferimentiJson) {
        Riferimento f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;
  }

  Future<List<Riferimento>> getByDescrizione(String descrizione) async {
    late List<Riferimento> riferimenti = [];

    _getMapping = "/get/getByDescrizione/"+descrizione;

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var riferimentoJson in riferimentiJson) {
        Riferimento f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }

    return riferimenti;
  }

  Future<List<Riferimento>> getRiferimentoBySTitolo(String titolo) async {
    late List<Riferimento> riferimenti = [];

    _getMapping = "/get/getBySTitolo/"+titolo;

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var riferimentoJson in riferimentiJson) {
        Riferimento f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }

    return riferimenti;
  }


  Future<List<Riferimento>> getCitazioniByUserId(int userID) async {
    late List<Riferimento> riferimenti = [];

    _getMapping = "/get/getCitazioniByUserId/"+userID.toString();

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var riferimentoJson in riferimentiJson) {
        Riferimento f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;
  }

  Future<List<Riferimento>> getByTipo(tipo_enum tipo) async {
    late List<Riferimento> riferimenti = [];

    _getMapping = "/get/getByTipo/"+tipo.toString().substring(10);

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      List<dynamic> riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(var riferimentoJson in riferimentiJson) {
        Riferimento f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;
  }

  Future<Riferimento?> creaRiferimento(Riferimento riferimento, Categoria categoria, int userID, Riferimento? rifCitanto) async {
    if(_typeCheck(riferimento)) {
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
    else return null;

  }

  Future<bool> aggiornaRiferimento(Riferimento riferimento) async {
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

  Future<bool> aggiornaRiferimentoAutore(Riferimento riferimento, int oldAutoreID, int newAutoreID) async {
    _getMapping = "/update/riferimentoAutore/"+riferimento.id_riferimento.toString()+"/"+oldAutoreID.toString()+"/"+newAutoreID.toString();
    _serverResponse = await put(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      return true;
    } else return false;
  }

  Future<bool> aggiornaRiferimentoCategoria(Riferimento riferimento, int oldCategoriaID, int newCategoriaID) async {
    _getMapping = "/update/riferimentoCategoria/"+riferimento.id_riferimento.toString()+"/"+oldCategoriaID.toString()+"/"+newCategoriaID.toString();
    _serverResponse = await put(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      return true;
    } else return false;
  }

  Future<bool> aggiornaRiferimentoCitazione(Riferimento riferimento, int oldCitatoID, int newCitatoID) async {
    _getMapping = "/update/riferimentoCitazione/"+riferimento.id_riferimento.toString()+"/"+oldCitatoID.toString()+"/"+newCitatoID.toString();
    _serverResponse = await put(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      return true;
    } else return false;
  }


  Future<bool> aggiungiAutore(Riferimento r, int autoreID) async {
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

  Future<bool> aggiungiCategoria(Riferimento r, int categoriaID) async {
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

  Future<bool> aggiungiCitazione(Riferimento citato, int citanteID) async {
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

  Future<bool> deleteRiferimento(Riferimento r) async {
    _getMapping = "/delete/"+r.id_riferimento.toString();

    _serverResponse = await delete(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) return true;
    else return false;
  }

  Future<bool> deleteRiferimentoAutore(Riferimento r, int autoreID) async {
    _getMapping = "/delete/riferimentoAutore/"+r.id_riferimento.toString()+"/"+autoreID.toString();

    _serverResponse = await delete(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) return true;
    else return false;
  }

  Future<bool> deleteRiferimentoCategoria(Riferimento r, int categoriaID) async {
    _getMapping = "/delete/riferimentoCategoria/"+r.id_riferimento.toString()+"/"+categoriaID.toString();

    _serverResponse = await delete(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) return true;
    else return false;
  }

  Future<bool> deleteRiferimentoCitazione(Riferimento r, int citazioneID) async {
    _getMapping = "/delete/riferimentoCitazione/"+r.id_riferimento.toString()+"/"+citazioneID.toString();

    _serverResponse = await delete(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) return true;
    else return false;
  }

  bool _typeCheck(Riferimento r) {
    switch (r.tipo) {
      case tipo_enum.Rivista:
        if(r.DOI != null) return false;
        else return true;
      case tipo_enum.Libro:
        if(r.DOI != null) return false;
        else return true;
      case tipo_enum.Fascicolo:
        if(r.isbn != null || r.editore != null || r.edizione != null || r.isnn != null) return false;
        else return true;
      case tipo_enum.Conferenza:
        if(r.isnn != null || r.isnn != null || r.pag_inizio != null || r.pag_fine != null || r.DOI != null || r.edizione != null || r.editore != null) return false;
        else return true;
      case tipo_enum.Articolo:
        if(r.isbn != null || r.DOI != null) return false;
        else return true;
      case null:
        return false;
    }
  }


}