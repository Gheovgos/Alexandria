import 'dart:convert';

import 'package:http/http.dart';
import '../Model/Categoria.dart';

class CategoriaNetwork {
  String url;
  String _requestMapping = "/categoria";
  late String _getMapping;
  late Response _serverResponse;
  late Categoria _categoria;
  late Map<String, dynamic> _categoriaMap;
  CategoriaNetwork(this.url);

  Future<Categoria?> getCategoriaById(int categoriaID) async {
    _getMapping = "/get/getCategoriaById/"+categoriaID.toString();
    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));

    if(_serverResponse.statusCode == 200) {
      _categoriaMap = jsonDecode(_serverResponse.body) as Map<String, dynamic>;
      print(_serverResponse.body);
      _categoria = Categoria.fromJson(_categoriaMap);

      return _categoria;
    }
    else return null;
  }
}