import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  String url = "";
  NetworkHelper();
  late Response r;
  Future<dynamic> getData() async { //example
    try {
      r = await get(Uri.parse(url));
      if (r.statusCode == 200) {
        var jsonString = jsonDecode(r.body);
        print(jsonDecode(r.body));
        return jsonString;
      } else {
        print(jsonDecode(r.body));
        return "Error!" + r.body;
      }
    } catch (p) {
      print(jsonDecode(r.body));
      return p.toString();
    }
  }
}
