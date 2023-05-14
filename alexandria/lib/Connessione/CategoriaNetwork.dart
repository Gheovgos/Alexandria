import 'dart:convert';

import 'package:http/http.dart';
import '../Model/Categoria.dart';

class CategoriaNetwork {
  String url;
  String requestMapping = "/categoria";
  late String getMapping;
  late Response serverResponse;
  late Categoria categoria;
  late Map<String, dynamic> categoriaMap;
  CategoriaNetwork(this.url);

  Future<Categoria?> getCategoriaById(int categoriaID) async {
    getMapping = "/get/getCategoriaById/"+categoriaID.toString();
    serverResponse = await get(Uri.parse(url+requestMapping+getMapping));

    if(serverResponse.statusCode == 200) {
      categoriaMap = jsonDecode(serverResponse.body) as Map<String, dynamic>;
      print(serverResponse.body);
      categoria = Categoria.fromJson(categoriaMap);

      return categoria;
    }
    else return null;
  }
}