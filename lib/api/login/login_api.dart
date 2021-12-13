import 'dart:convert';
import 'package:limpamais_application/api/api_response.dart';
import 'package:limpamais_application/models/user.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<User>> login(String email, String password) async {
    try {
      Uri url =
          Uri.parse('http://10.0.2.2:3333/users/login');

      Map<String, String> headers = {"Content-type": "application/json"};

      Map params = {"email": email, "password": password};

      //Recebe o Map e transforma em string
      String stringParams = json.encode(params);

      var response = await http.post(url, body: stringParams, headers: headers);
      print(response.body);

      //Recebe uma string e transforma em Map Object
      Map<String, dynamic> responseMap = json.decode(response.body);

      if (response.statusCode == 200) {
        final User user = User.fromJson(responseMap);

        user.save();

        //construtor nomeado "ok" para caso a requisição tiver êxito
        return ApiResponse.ok(user);
      }
      //construtor nomeado "error" para caso a requisição não tiver êxito
      return ApiResponse.error(responseMap["error"]);
      
    } catch (error, exception) {
      
      print("Erro no login $error > $exception");
      return ApiResponse.error("Não foi possível fazer login, tente novamente mais tarde.");
    }
  }
}
