import 'dart:convert';
import 'package:limpamais_application/api/api_response.dart';
import 'package:limpamais_application/models/services.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
  static Future<ApiResponse<String>> createService(int userId, int diaristId, String appointmentDate) async {
    try {
      Uri url =
          Uri.parse('http://10.0.2.2:3333/services');

      Map<String, String> headers = {"Content-type": "application/json"};

      Map params = {"user_id": userId, "diarist_id": diaristId, "appointment_date": appointmentDate};

      String stringParams = json.encode(params);

      var response = await http.post(url, body: stringParams, headers: headers);

      if (response.statusCode == 201) {
        return ApiResponse.ok("Agendamento realizado com sucesso!");
      }

      return ApiResponse.error("Algo deu errado. Tente novamente mais tarde.");
      
    } catch (error, exception) {
       return ApiResponse.error("$error > $exception");
    }
  }
}
