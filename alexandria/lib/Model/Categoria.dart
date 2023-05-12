import 'dart:core';

class Categoria {
  late int id_categoria;
  late String descr_categoria;
  late int user_id;
  late int id_sopra_categoria;


  Categoria.fromJson(Map<String, dynamic>  json)
      : id_categoria = json['id_categoria'] as int,
        descr_categoria = json['descr_categoria'] as String,
        user_id = json['user_id'] as int,
        id_sopra_categoria = json['id_sopra_categoria'] as int;

  Categoria(int id_categoria, String descr_categoria, int user_id, int id_sopra_categoria) {
    this.id_sopra_categoria = id_sopra_categoria;
    this.user_id = user_id;
    this.id_sopra_categoria = id_sopra_categoria;
  }
}

