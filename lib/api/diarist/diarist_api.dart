import 'package:limpamais_application/models/diarist.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:limpamais_application/models/diarist_appointment.dart';
import 'package:limpamais_application/models/diarist_details.dart';

class DiaristsApi {
static Future<String> createUser(String name, String email, String password, String phone, String street, String number, String city, String state, String dailyRate, String note) async {
      Uri url =
          Uri.parse('http://localhost:3333/diarists');

      Map<String, String> headers = {"Content-type": "application/json"};

      Map params = {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "street": street,
        "number": number,
        "city": city,
        "state": state,
        "daily_rate": dailyRate,
        "note": note
      };

      String stringParams = convert.json.encode(params);

      var response = await http.post(url, body: stringParams, headers: headers);

      if (response.statusCode == 201) {
        return "Usuário criado com sucesso!";
      }
      
      return "";
  }

  static Future<List<Diarist>> getDiarists({String? city}) async {
    Uri url = Uri.parse('http://localhost:3333/diarists');

    final Map<String, String> headers = {"Content-type": "application/json"};
    final Map<String, String> queryParameters = {'city': '$city'};
    final finalUrl = url.replace(queryParameters: queryParameters);

    var response = await http.get(finalUrl, headers: headers);

    List<dynamic> list = convert.json.decode(response.body);

    final List<Diarist> diarists =
        list.map((diarist) => Diarist.fromJson(diarist)).toList();

    return diarists;
  }

  static Future<DiaristDetails> getDiaristDetails(int id) async {
    Uri url = Uri.parse('http://localhost:3333/diarists/$id');

    Map<String, String> headers = {"Content-type": "application/json"};

    var response = await http.get(url);

    Map<String, dynamic> diaristDetailsMap = convert.json.decode(response.body);

    DiaristDetails diaristDetails = DiaristDetails.fromJson(diaristDetailsMap);

    return diaristDetails;
  }
  
  static Future<List<DiaristAppointment>> getUserServices(int id) async {
     Uri url =
          Uri.parse('http://localhost:3333/diarists/$id/services');

      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.get(url, headers: headers);

      List<dynamic> list = convert.json.decode(response.body);

    final List<DiaristAppointment> userAppointments =
        list.map((userAppointment) => DiaristAppointment.fromJson(userAppointment)).toList();

      return userAppointments;
  }
}
