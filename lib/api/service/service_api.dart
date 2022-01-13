import 'dart:convert';
import 'package:limpamais_application/api/api_response.dart';
import 'package:limpamais_application/models/service_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class ServiceApi {
  static Future<ApiResponse<String>> createService(
      int userId, int diaristId, String appointmentDate) async {
    try {
      Uri url = Uri.parse('http://10.0.2.2:3333/services');

      Map<String, String> headers = {"Content-type": "application/json"};

      Map params = {
        "user_id": userId,
        "diarist_id": diaristId,
        "appointment_date": appointmentDate
      };

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

  static Future<ApiResponse<ServiceDetails>> getServiceById(int id) async {
    try {
      Uri url = Uri.parse('http://10.0.2.2:3333/services/$id');

      Map<String, String> headers = {"Content-type": "application/json"};

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> diaristDetailsMap = convert.json.decode(response.body);

        ServiceDetails diaristDetails =
            ServiceDetails.fromJson(diaristDetailsMap);

        return ApiResponse.ok(diaristDetails);
      }

      return ApiResponse.error("Algo deu errado. Tente novamente mais tarde.");
    } catch (error, exception) {
      
      return ApiResponse.error("$error > $exception");
    }
  }

  static Future<ApiResponse<String>> updateToScheduled(int id) async {
     Uri url = Uri.parse('http://10.0.2.2:3333/services/$id');

      Map<String, String> headers = {"Content-type": "application/json"};

      Map params = {
        "status": "scheduled and not rated"
      };

      String stringParams = json.encode(params);

      try {
        var response = await http.patch(url, body: stringParams, headers: headers);

      if (response.statusCode == 204) {
        return ApiResponse.ok("Agendamento realizado com sucesso!");
      }

      return ApiResponse.error("Algo deu errado. Tente novamente mais tarde.");
    } catch (error, exception) {
      return ApiResponse.error("$error > $exception");
    }
  }

  static Future<ApiResponse<String>> updateToRejected(int id) async {
     Uri url = Uri.parse('http://10.0.2.2:3333/services/$id');

      Map<String, String> headers = {"Content-type": "application/json"};

      Map params = {
        "status": "rejected"
      };

      String stringParams = json.encode(params);

      try {
        var response = await http.post(url, body: stringParams, headers: headers);

      if (response.statusCode == 204) {
        return ApiResponse.ok("Agendamento rejeitado!");
      }

      return ApiResponse.error("Algo deu errado. Tente novamente mais tarde.");
    } catch (error, exception) {
      return ApiResponse.error("$error > $exception");
    }
  }
}
