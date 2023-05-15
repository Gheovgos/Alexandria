import 'dart:convert';
import 'dart:core';

class Categoria {

  Categoria(int id_categoria, String descr_categoria, int user_id,
      Categoria? id_sopra_categoria) {
    this.id_categoria = id_categoria;
    this.descr_categoria = descr_categoria;
    this.user_id = user_id;
    this.super_Categoria = id_sopra_categoria;
  }

  late int id_categoria;
  late String descr_categoria;
  late int user_id;
  late Categoria? super_Categoria;


  Categoria.fromJson(Map<String, dynamic> json)
      : id_categoria = json['id_categoria'] as int {
    if (json['nome'] != null) {
      descr_categoria = json['nome'] as String;
    } else {
      descr_categoria = json['descr_categoria'] as String;
    }

    if (json['id_utente'] != null) {
      user_id = json['id_utente'] as int;
    } else {
      user_id = json['user_id'] as int;
    }

    if (json['super_Categoria'] != null) {
      Map<String, dynamic> subJson = json['super_Categoria'] as Map<String, dynamic>;
      super_Categoria = Categoria.fromJson(subJson);
    } else {
      super_Categoria = null;
    }
  }


}