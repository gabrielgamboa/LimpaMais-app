import 'package:limpamais_application/models/diarist.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:limpamais_application/models/diarist_details.dart';

class DiaristsApi {
  static Future<List<Diarist>> getDiarists() async {
      Uri url =
          Uri.parse('http://10.0.2.2:3333/diarists');

      Map<String, String> headers = {"Content-type": "application/json"};

      var response = await http.get(url);

      List<dynamic> list = convert.json.decode(response.body);
      
      final List<Diarist> diarists = list.map((diarist) => Diarist.fromJson(diarist)).toList();

      return diarists;
  }

  static Future<DiaristDetails> getDiaristDetails(int id) async {
    Uri url =
          Uri.parse('http://10.0.2.2:3333/diarists/$id');

      Map<String, String> headers = {"Content-type": "application/json"};

      var response = await http.get(url);

      Map<String, dynamic> diaristDetailsMap = convert.json.decode(response.body);

      DiaristDetails diaristDetails = DiaristDetails.fromJson(diaristDetailsMap);

      return diaristDetails;
  }
}
