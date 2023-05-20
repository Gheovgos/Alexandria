import 'dart:core';
import 'tipo_enum.dart';

class Riferimento {
  late int id_riferimento;
  late String titolo_riferimento;
  late DateTime data_riferimento;
  late tipo_enum? tipo;
  late String? URL;
  late int? DOI;
  late bool on_line;
  late String? descr_riferimento;
  late String? editore;
  late String? isbn;
  late String? isnn;
  late String? luogo;
  late int? pag_inizio;
  late int? pag_fine;
  late int? edizione;

  Riferimento.fromJson(Map<String, dynamic>  json)
      : id_riferimento = json['id_Rif'] as int,
        titolo_riferimento = json['titolo'] as String,
        data_riferimento = DateTime.parse(json['dataCreazione'] as String),
        tipo = convertStringToEnum(json['tipo'] as String),
        URL = json['url'] as String?,
        DOI = json['doi'] as int?,
        on_line = json['digitale'] as bool,
        descr_riferimento = json['descrizione'] as String?,
        editore = json['editore'] as String?,
        isbn = json['isbn'] as String?,
        isnn = json['isnn'] as String?,
        luogo = json['luogo'] as String?,
        pag_inizio = json['pag_inizio'] as int?,
        pag_fine = json['pag_fine'] as int?,
        edizione = json['edizione'] as int?;

  Riferimento(int id_riferimento, String titolo_riferimento, DateTime data_riferimento, tipo_enum tipo,
      String? URL, int? DOI, bool on_line, String? descr_riferimento, String? editore, String? isbn, String? isnn,
      String? luogo, int? pag_inizio, int? pag_fine, int? edizione) {
    this.id_riferimento = id_riferimento;
    this.titolo_riferimento = titolo_riferimento;
    this.data_riferimento = data_riferimento;
    this.tipo = tipo;
    this.URL = URL;
    this.DOI = DOI;
    this.on_line = on_line;
    this.descr_riferimento = descr_riferimento;
    this.editore = editore;
    this.isbn = isbn;
    this.isnn = isnn;
    this.luogo = luogo;
    this.pag_inizio = pag_inizio;
    this.pag_fine = pag_fine;
    this.edizione = edizione;

  }




}