import 'package:http/http.dart';
import 'dart:convert';

class CategoriaNetwork {
  String url;
  String requestMapping = "/categoria";
  late String getMapping;
  late Response serverResponse;
  CategoriaNetwork(this.url);
}