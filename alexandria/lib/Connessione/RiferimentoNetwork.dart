import 'dart:convert';

import 'package:http/http.dart';
import '../Model/Riferimento.dart';

class RiferimentoNetwork {
  String url;
  String _requestMapping = "/api/v1/riferimento/";
  late String _getMapping;
  late Response _serverResponse;
  late Riferimento _riferimento;
  late Map<String, dynamic> _riferimentoMap;
  RiferimentoNetwork(this.url);

  Future<Riferimento?> getRiferimentoById(int rif_id) async {
    _getMapping = "get/getRiferimentoById/"+rif_id.toString();
    print(url+_requestMapping+_getMapping);

    _serverResponse = await get(Uri.parse(url+_requestMapping+_getMapping));
    print(url+_requestMapping+_getMapping);



    if(_serverResponse.statusCode == 200) {
      _riferimentoMap = jsonDecode(_serverResponse.body) as Map<String, dynamic>;
      _riferimento = Riferimento.fromJson(_riferimentoMap);

      return _riferimento;
    }
    else return null;

  }
}