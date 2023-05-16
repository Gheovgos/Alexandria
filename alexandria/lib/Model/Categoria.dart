import 'dart:convert';
import 'dart:core';

class Categoria {

  Categoria(int id_categoria, String descr_categoria, int user_id,
      int? id_sopra_categoria) {
    this.id_categoria = id_categoria;
    this.nome = descr_categoria;
    this.user_id = user_id;
    this.super_Categoria = id_sopra_categoria;
  }

  late int id_categoria;
  late String nome;
  late int user_id;
  late int? super_Categoria;


  Categoria.fromJson(Map<String, dynamic> json)
      : id_categoria = json['id_categoria'] as int,
        nome = json['descr_categoria'] as String,
        user_id = json['id_utente'] as int,
        super_Categoria = json['super_Categoria'] as int?;

}