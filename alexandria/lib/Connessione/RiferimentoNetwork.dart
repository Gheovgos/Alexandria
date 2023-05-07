import 'package:http/http.dart';
import 'dart:convert';

class RiferimentoNetwork {
  String url;
  String requestMapping = "/api/v1/riferimento";
  late String getMapping;
  late Response serverResponse;
  RiferimentoNetwork(this.url);
}