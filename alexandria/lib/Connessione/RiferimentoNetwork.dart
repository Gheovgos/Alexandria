import 'dart:convert';

import 'package:alexandria/Model/Categoria.dart';
import 'package:alexandria/Model/Riferimento.dart';
import 'package:alexandria/Model/Utente.dart';
import 'package:alexandria/Model/tipo_enum.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RiferimentoNetwork {
  RiferimentoNetwork(this.url);
  String url;
  final String _requestMapping = '/api/v1/riferimento';
  late String _getMapping;
  late Response _serverResponse;
  late Map<String, dynamic> _riferimentoMap;

  Future<List<Riferimento>> ricerca(String? titolo, int? doi, String? autore, List<Categoria> categoria, List<tipo_enum> tipo) async {
    late var riferimenti = <Riferimento>[];
    late var riferimentiCategoria = <Riferimento>[];
    late var riferimentiTipo = <Riferimento>[];


    //Ricerca per titolo
    if(titolo != null && doi == null && autore == null) {
      riferimenti = await getRiferimentoBySTitolo(titolo);

      if(categoria.isNotEmpty)  {
        for(final c in categoria) {
          riferimentiCategoria += await getRiferimentoByCategoria(c.id_categoria);
        }
        riferimenti = _filterList(riferimenti, riferimentiCategoria);
      }


      for(final t in tipo) {
        riferimentiTipo += await getByTipo(t);
      }

      return _filterList(riferimenti, riferimentiTipo);
    }

    //Ricerca per DOI
    if(titolo == null && doi != null && autore == null) {
      riferimenti = await getRiferimentoByDOI(doi);

      if(categoria.isNotEmpty)  {
        for(final c in categoria) {
          riferimentiCategoria += await getRiferimentoByCategoria(c.id_categoria);
        }
        riferimenti = _filterList(riferimenti, riferimentiCategoria);
      }
      for(final t in tipo) {
        riferimentiTipo += await getByTipo(t);
      }

      return _filterList(riferimenti, riferimentiTipo);
    }
    
    if(titolo == null && doi == null && autore != null) {

      riferimenti = await getRiferimentoByAutore(autore);
      if(categoria.isNotEmpty)  {
        for(final c in categoria) {
          riferimentiCategoria += await getRiferimentoByCategoria(c.id_categoria);
        }
        riferimenti = _filterList(riferimenti, riferimentiCategoria);
      }
      for(final t in tipo) {
        riferimentiTipo += await getByTipo(t);
      }

      return _filterList(riferimenti, riferimentiTipo);
    }

    if(titolo == null && doi == null && autore == null) {
      print('ERROR: Nessun parametro inserito per la ricerca di un riferimento. Ritorno lista vuota');
    }

      return riferimenti;
  }

  List<Riferimento> _filterList(List<Riferimento> primaLista, List<Riferimento> secondaLista) {
    if(secondaLista.isEmpty) return primaLista;

    final result = <Riferimento>[];

    for(final primo in primaLista) {
      for(final secondo in secondaLista) {

        if(primo.id_riferimento == secondo.id_riferimento) {
          result.add(primo);
        }
      }
    }

    return result;
  }

  Future<Riferimento?> getRiferimentoById(int rif_id) async {
    _getMapping = '/get/getRiferimentoById/$rif_id';

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      _riferimentoMap = jsonDecode(_serverResponse.body) as Map<String, dynamic>;

      return Riferimento.fromJson(_riferimentoMap);
    }
    else {
      return null;
    }

  }
  
  Future<Riferimento?> getRiferimentoByNome(String titolo) async {
    _getMapping = '/get/getRiferimentoByNome/$titolo';

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      _riferimentoMap = jsonDecode(_serverResponse.body) as Map<String, dynamic>;

      return Riferimento.fromJson(_riferimentoMap);
    }
    else {
      return null;
    }
  }

  Future<List<Riferimento>> findAll() async {
    late final riferimenti = <Riferimento>[];
    _getMapping = '/get/findAll';
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final riferimentoJson in riferimentiJson) {
        final f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;
  }

  Future<List<Riferimento>> getRiferimentoByUserId(int userID) async {
    late final riferimenti = <Riferimento>[];
    _getMapping = '/get/getRiferimentoByUserId/$userID';


    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final riferimentoJson in riferimentiJson) {
        final f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;

  }

  //Dato un riferimento, vengono restituiti tutti i riferimenti che tale riferimento cita.

  Future<List<Riferimento>> getRiferimentiCitati(Riferimento riferimento) async {
    late final riferimenti = <Riferimento>[];
    _getMapping = '/get/getByRiferimento/${riferimento.id_riferimento}';

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final riferimentoJson in riferimentiJson) {
        final f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;
  }

  //Dato un riferimento, vengono restituiti tutti i riferimenti che citano tale riferimento

  Future<List<Riferimento>> getRiferimentiCitanti(Riferimento riferimento) async {
    late final riferimenti = <Riferimento>[];
    _getMapping = '/get/getRiferimentiCitanti/${riferimento.id_riferimento}';

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final riferimentoJson in riferimentiJson) {
        final f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;
  }

  Future<List<Riferimento>> getRiferimentoByAutore(String testo) async {
    late final riferimenti = <Riferimento>[];
    _getMapping = '/get/getByAutoreSearch/$testo';

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final riferimentoJson in riferimentiJson) {
        final f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;

  }

  Future<List<Riferimento>> getRiferimentoByCategoria(int categoriaID) async {
    late final riferimenti = <Riferimento>[];
    _getMapping = '/get/getByCategoria/$categoriaID';

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final riferimentoJson in riferimentiJson) {
        final f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;

  }

  Future<List<Riferimento>> getRiferimentoByDOI(int DOI) async {
    late final riferimenti = <Riferimento>[];
    _getMapping = '/get/getByDOISearch/$DOI';

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final riferimentoJson in riferimentiJson) {
        final f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;
  }

  Future<List<Riferimento>> getByDescrizione(String descrizione) async {
    late final riferimenti = <Riferimento>[];

    _getMapping = '/get/getByDescrizione/$descrizione';

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final riferimentoJson in riferimentiJson) {
        final f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }

    return riferimenti;
  }

  Future<List<Riferimento>> getRiferimentoBySTitolo(String titolo) async {
    late final riferimenti = <Riferimento>[];

    _getMapping = '/get/getBySTitolo/$titolo';

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final riferimentoJson in riferimentiJson) {
        final f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }

    return riferimenti;
  }


  Future<List<Riferimento>> getCitazioniByUserId(int userID) async {
    late final riferimenti = <Riferimento>[];

    _getMapping = '/get/getCitazioniByUserId/$userID';

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final riferimentoJson in riferimentiJson) {
        final f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;
  }

  Future<List<Riferimento>> getByTipo(tipo_enum tipo) async {
    late final riferimenti = <Riferimento>[];

    _getMapping = '/get/getByTipo/${tipo.toString().substring(10)}';

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      final riferimentiJson = jsonDecode(_serverResponse.body) as List<dynamic>;
      for(final riferimentoJson in riferimentiJson) {
        final f = Riferimento.fromJson(riferimentoJson as Map<String, dynamic>);
        riferimenti.add(f);
      }

    }
    return riferimenti;
  }

  Future<Riferimento?> creaRiferimento(Riferimento riferimento, Categoria categoria, int userID) async {
    if(_typeCheck(riferimento)) {
      _getMapping = '/create/$userID/${categoria.id_categoria}';

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

      if(_serverResponse.statusCode == 200) {
        return await getRiferimentoByNome(riferimento.titolo_riferimento);
      } else {
        return null;
      }
    }
    else {
      return null;
    }

  }

  Future<bool> aggiornaRiferimento(Riferimento riferimento,List<Categoria> oldCategoria, List<Categoria> newCategoria,
      List<Riferimento> oldCitazione, List<Riferimento> newCitazione,
      List<Utente> oldAutore, List<Utente> newAutore,) async {
    _getMapping = '/update';
    if(_typeCheck(riferimento)) {
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
        var i = 0;
        var categoriaBool = true;
        var citazioneBool = true;
        var autoreBool = true;

        if(oldCategoria.length == newCategoria.length) {
          for(final c in oldCategoria) {
            if(!(await aggiornaRiferimentoCategoria(riferimento, c.id_categoria, newCategoria[i].id_categoria))) {
              categoriaBool = false;
            }
            i++;
          }
        } else {
          categoriaBool = false;
        }
        i = 0;

        if(oldCitazione.length == newCitazione.length) {
          for(final c in oldCitazione) {
            if(!(await aggiornaRiferimentoCitazione(riferimento, c.id_riferimento, newCitazione[i].id_riferimento))) {
              citazioneBool = false;
            }
            i++;
          }
        } else {
          citazioneBool = false;
        }
        i = 0;
        if(oldAutore.length == newAutore.length) {
          for(final a in oldAutore) {
            if(!(await aggiornaRiferimentoAutore(riferimento, a.user_ID, newAutore[i].user_ID))) {
              autoreBool = false;
            }
            i++;
          }
        } else {
          citazioneBool = false;
        }

        return categoriaBool && citazioneBool && autoreBool;

      } else {
        return false;
      }
    }
    else {
      return false;
    }

  }

  Future<bool> aggiornaRiferimentoAutore(Riferimento riferimento, int oldAutoreID, int newAutoreID) async {
    _getMapping = '/update/riferimentoAutore/${riferimento.id_riferimento}/$oldAutoreID/$newAutoreID';
    _serverResponse = await put(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> aggiornaRiferimentoCategoria(Riferimento riferimento, int oldCategoriaID, int newCategoriaID) async {
    _getMapping = '/update/riferimentoCategoria/${riferimento.id_riferimento}/$oldCategoriaID/$newCategoriaID';
    _serverResponse = await put(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> aggiornaRiferimentoCitazione(Riferimento riferimento, int oldCitatoID, int newCitatoID) async {
    _getMapping = '/update/riferimentoCitazione/${riferimento.id_riferimento}/$oldCitatoID/$newCitatoID';
    _serverResponse = await put(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> aggiungiAutore(Riferimento r, int autoreID) async {
    final riferimento = await getRiferimentoByNome(r.titolo_riferimento);
      if(riferimento != null) {
        _getMapping = '/create/aggiungiAutore/$autoreID';
        _serverResponse = await post(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
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
        } else {
          return false;
        }
      } else {
        return false;
      }

  }

  Future<bool> aggiungiCategoria(Riferimento r, int categoriaID) async {
    final riferimento = await getRiferimentoByNome(r.titolo_riferimento);
    if(riferimento != null) {
      _getMapping = '/create/aggiungiCategoria/$categoriaID';
      _serverResponse = await post(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
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
      } else {
        return false;
      }
    } else {
      return false;
    }

  }

  Future<bool> aggiungiCitazione(Riferimento citato, int citanteID) async {
    final riferimento = await getRiferimentoByNome(citato.titolo_riferimento);
    if(riferimento != null) {
      _getMapping = '/create/aggiungiCitazione/$citanteID';
      _serverResponse = await post(Uri.parse(url+_requestMapping+_getMapping), headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8',
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
      } else {
        return false;
      }
    } else {
      return false;
    }

  }

  Future<bool> deleteRiferimento(Riferimento r) async {
    _getMapping = '/delete/${r.id_riferimento}';

    _serverResponse = await delete(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteRiferimentoAutore(Riferimento r, int autoreID) async {
    _getMapping = '/delete/riferimentoAutore/${r.id_riferimento}/$autoreID';

    _serverResponse = await delete(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteRiferimentoCategoria(Riferimento r, int categoriaID) async {
    _getMapping = '/delete/riferimentoCategoria/${r.id_riferimento}/$categoriaID';

    _serverResponse = await delete(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteRiferimentoCitazione(Riferimento r, int citazioneID) async {
    _getMapping = '/delete/riferimentoCitazione/${r.id_riferimento}/$citazioneID';

    _serverResponse = await delete(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  bool _typeCheck(Riferimento r) {
    switch (r.tipo) {
      case tipo_enum.Rivista:
        if(r.DOI != null) {
          return false;
        } else {
          return true;
        }
      case tipo_enum.Libro:
        if(r.DOI != null) {
          return false;
        } else {
          return true;
        }
      case tipo_enum.Fascicolo:
        if(r.isbn != null || r.editore != null || r.edizione != null || r.isnn != null) {
          return false;
        } else {
          return true;
        }
      case tipo_enum.Conferenza:
        if(r.isnn != null || r.isbn != null || r.pag_inizio != null || r.pag_fine != null || r.DOI != null || r.edizione != null || r.editore != null) {
          return false;
        } else {
          return true;
        }
      case tipo_enum.Articolo:
        if(r.isbn != null || r.DOI != null) {
          return false;
        } else {
          return true;
        }
      case null:
        return false;
    }
  }


}
