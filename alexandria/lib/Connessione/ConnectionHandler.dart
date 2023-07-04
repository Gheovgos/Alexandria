import 'dart:async';
import 'package:alexandria/Connessione/CategoriaNetwork.dart';
import 'package:alexandria/Connessione/RiferimentoNetwork.dart';
import 'package:alexandria/Connessione/UtenteNetwork.dart';
import 'package:alexandria/Model/Categoria.dart';
import 'package:alexandria/Model/Riferimento.dart';
import 'package:alexandria/Model/Utente.dart';
import 'package:alexandria/Model/tipo_enum.dart';
import 'package:http/http.dart';

class NetworkHelper {
  NetworkHelper();

  final String url = 'http://13.51.162.83:8089'; //IP di AWS: 'http://13.51.162.83:8089'
  late final UtenteNetwork _unet = UtenteNetwork(url);
  late final CategoriaNetwork _catnet = CategoriaNetwork(url);
  late final RiferimentoNetwork _rifnet = RiferimentoNetwork(url);

  Future<Utente?> login(String username, String password) async {
    return _unet.login(username, password);
  }

  Future<Utente?> registrazione(String username, String password, String nome, String cognome, String email) async {
    return _unet.registrazione(username, password, nome, cognome, email);
  }

  Future<bool> hasConnection() async {
    try {
      await get(Uri.parse('$url/api/v1/utente/create/getUtenteById/0')).timeout(const Duration(seconds: 4));
    } on Exception {
      return false;
    }
    return true;
  }

  Future<Utente?> getUtenteById(int user_id) async {
    return _unet.getUtenteById(user_id);
  }

  Future<List<Utente>?> findAllUsers() async {
    return _unet.findAll();
  }

  Future<List<Utente>?> getAutoriByRiferimento(int riferimentoID) async {
    return _unet.getAutoriByRiferimento(riferimentoID);
  }

  Future<bool> deleteUserFromId(int user_id) async {
    return _unet.deleteUserFromId(user_id);
  }

  Future<bool> updateUser(Utente newUtente) async {
    return _unet.updateUser(newUtente);
  }

  Future<Categoria?> getCategoriaById(int categoriaID) async {
    return _catnet.getCategoriaById(categoriaID);
  }

  Future<List<Categoria>?> findAllCategories() async {
    return _catnet.findAll();
  }

  Future<Categoria?> getCategoriaByName(String nome) async {
    return _catnet.getCategoriaByName(nome);
  }

  Future<List<Categoria>> getCategoriaByRiferimento(int id_riferimento) async {
    return _catnet.getCategoriaByRiferimento(id_riferimento);
  }

  Future<List<Categoria>?> getSopraCategorie(int categoriaID) async {
    return _catnet.getSopraCategorie(categoriaID);
  }

  Future<List<Categoria>?> getSottoCategorie(int categoriaID) async {
    return _catnet.getSottoCategorie(categoriaID);
  }

  Future<Categoria?> createCategoria(String nome, int user_id, int? superCategoria) async {
    return _catnet.creaCategoria(nome, user_id, superCategoria);
  }

  Future<bool> updateCategoria(Categoria newCategoria) async {
    return _catnet.updateCategoria(newCategoria);
  }

  Future<bool> deleteCategoria(Categoria c) async {
    return _catnet.deleteCategoriaById(c);
  }

  Future<Riferimento?> getRiferimentoById(int rif_id) async {
    return _rifnet.getRiferimentoById(rif_id);
  }

  Future<List<Riferimento>> ricerca(
    String? titolo,
    int? doi,
    String? autore,
    List<Categoria> categoria,
    List<tipo_enum> tipo,
  ) async {
    return _rifnet.ricerca(titolo, doi, autore, categoria, tipo);
  }

  Future<List<Riferimento>?> findAllRiferimenti() async {
    return _rifnet.findAll();
  }

  Future<List<Riferimento>?> getRiferimentoByUserId(int userID) async {
    return _rifnet.getRiferimentoByUserId(userID);
  }

  Future<List<Riferimento>> getRiferimentoBySTitolo(String titolo) async {
    return _rifnet.getRiferimentoBySTitolo(titolo);
  }

  Future<List<Riferimento>?> getRiferimentoByCategoria(int categoriaID) async {
    return _rifnet.getRiferimentoByCategoria(categoriaID);
  }

  Future<Riferimento?> createRiferimento(Riferimento? riferimento, Categoria categoria, int userID) async {
    if (riferimento == null) {
      return null;
    } else {
      return _rifnet.creaRiferimento(riferimento, categoria, userID);
    }
  }

  Future<bool> aggiungiAutore(Riferimento riferimento, int autoreID) async {
    return _rifnet.aggiungiAutore(riferimento, autoreID);
  }

  Future<bool> aggiungiCategoria(Riferimento riferimento, int categoriaID) async {
    return _rifnet.aggiungiCategoria(riferimento, categoriaID);
  }

  Future<bool> aggiungiCitazione(Riferimento riferimento, int citanteID) async {
    return _rifnet.aggiungiCitazione(riferimento, citanteID);
  }

  Future<Riferimento?> getRiferimentoByNome(String titolo) async {
    return _rifnet.getRiferimentoByNome(titolo);
  }

  Future<bool> aggiornaRiferimento(
    Riferimento riferimento,
    List<Categoria> oldCategoria,
    List<Categoria> newCategoria,
    List<Riferimento> oldCitazione,
    List<Riferimento> newCitazione,
    List<Utente> oldAutore,
    List<Utente> newAutore,
  ) async {
    return _rifnet.aggiornaRiferimento(
      riferimento,
      oldCategoria,
      newCategoria,
      oldCitazione,
      newCitazione,
      oldAutore,
      newAutore,
    );
  }

  Future<bool> aggiornaRiferimentoAutore(Riferimento riferimento, int oldAutoreID, int newAutoreID) async {
    return _rifnet.aggiornaRiferimentoAutore(riferimento, oldAutoreID, newAutoreID);
  }

  Future<bool> aggiornaRiferimentoCategoria(Riferimento riferimento, int oldCategoriaID, int newCategoriaID) async {
    return _rifnet.aggiornaRiferimentoCategoria(riferimento, oldCategoriaID, newCategoriaID);
  }

  Future<bool> aggiornaRiferimentoCitazione(Riferimento riferimento, int oldCitatoID, int newCitatoID) async {
    return _rifnet.aggiornaRiferimentoCitazione(riferimento, oldCitatoID, newCitatoID);
  }

  Future<List<Riferimento>?> getRiferimentiCitati(Riferimento riferimento) async {
    return _rifnet.getRiferimentiCitati(riferimento);
  }

  Future<List<Riferimento>?> getRiferimentiCitanti(Riferimento riferimento) async {
    return _rifnet.getRiferimentiCitanti(riferimento);
  }

  Future<List<Riferimento>> getRiferimentoByAutore(String nome) async {
    return _rifnet.getRiferimentoByAutore(nome);
  }

  Future<List<Riferimento>?> getRiferimentoByDOI(int DOI) async {
    return _rifnet.getRiferimentoByDOI(DOI);
  }

  Future<List<Riferimento>> getByDescrizione(String descrizione) async {
    return _rifnet.getByDescrizione(descrizione);
  }

  Future<List<Riferimento>> getCitazioniByUserId(int userID) async {
    return _rifnet.getCitazioniByUserId(userID);
  }

  Future<List<Riferimento>> getByTipo(tipo_enum tipo) async {
    return _rifnet.getByTipo(tipo);
  }

  Future<bool> deleteRiferimento(Riferimento r) async {
    return _rifnet.deleteRiferimento(r);
  }

  Future<bool> deleteRiferimentoAutore(Riferimento r, int autoreID) async {
    return _rifnet.deleteRiferimentoAutore(r, autoreID);
  }

  Future<bool> deleteRiferimentoCategoria(Riferimento r, int categoriaID) async {
    return _rifnet.deleteRiferimentoCategoria(r, categoriaID);
  }

  Future<bool> deleteRiferimentoCitazione(Riferimento r, int citazioneID) async {
    return _rifnet.deleteRiferimentoCitazione(r, citazioneID);
  }
}
