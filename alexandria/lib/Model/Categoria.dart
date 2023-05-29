import 'dart:core';

class Categoria {
  Categoria(
    this.id_categoria,
    this.nome,
    this.user_id,
    this.super_Categoria,
  );
  Categoria.fromJson(Map<String, dynamic> json)
      : id_categoria = json['id_categoria'] as int,
        nome = json['descr_categoria'] as String,
        user_id = json['id_utente'] as int,
        super_Categoria = json['super_Categoria'] as int?;

  late int id_categoria;
  late String nome;
  late int user_id;
  int? super_Categoria;
}
