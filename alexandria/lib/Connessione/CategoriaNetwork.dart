import 'dart:convert';

import 'package:http/http.dart';

class CategoriaNetwork {
  String url;
  String requestMapping = "/categoria";
  late String getMapping;
  late Response serverResponse;
  CategoriaNetwork(this.url);
}