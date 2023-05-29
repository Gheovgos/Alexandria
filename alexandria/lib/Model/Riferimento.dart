import 'dart:core';
import 'package:alexandria/Model/tipo_enum.dart';

class Riferimento {
  Riferimento(
    this.id_riferimento,
    this.titolo_riferimento,
    this.data_riferimento,
    tipo_enum this.tipo,
    this.URL,
    this.DOI,
    this.on_line,
    this.descr_riferimento,
    this.editore,
    this.isbn,
    this.isnn,
    this.luogo,
    this.pag_inizio,
    this.pag_fine,
    this.edizione,
  );

  Riferimento.fromJson(Map<String, dynamic> json)
      : id_riferimento = json['id_Rif'] as int,
        titolo_riferimento = json['titolo'] as String,
        data_riferimento = DateTime.parse(json['dataCreazione'] as String),
        tipo = convertStringToEnum(json['tipo'] as String),
        URL = json['url'] as String?,
        DOI = json['doi'] as int?,
        on_line = json['on_line'] as bool,
        descr_riferimento = json['descrizione'] as String?,
        editore = json['editore'] as String?,
        isbn = json['isbn'] as String?,
        isnn = json['isnn'] as String?,
        luogo = json['luogo'] as String?,
        pag_inizio = json['pag_inizio'] as int?,
        pag_fine = json['pag_fine'] as int?,
        edizione = json['edizione'] as int?;

  Riferimento.empty() {
    id_riferimento = 0;
    titolo_riferimento = '';
    data_riferimento = DateTime.now();
  }
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
}
