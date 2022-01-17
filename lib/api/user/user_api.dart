import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:limpamais_application/models/user.dart';
import 'package:limpamais_application/models/user_appointments.dart';
class UserApi {
  static Future<String> createUser(String name, String email, String password, String phone, String street, String number, String city, String state) async {
      Uri url =
          Uri.parse('http://localhost:3333/users');

      Map<String, String> headers = {"Content-type": "application/json"};

      Map params = {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "street": street,
        "number": number,
        "city": city,
        "state": state
      };

      String stringParams = convert.json.encode(params);

      var response = await http.post(url, body: stringParams, headers: headers);

      if (response.statusCode == 201) {
        return "Usuário criado com sucesso!";
      }
      
      return "";
  }

  static Future<User> getUser(int id) async {
      Uri url =
          Uri.parse('http://localhost:3333/users/$id');

      Map<String, String> headers = {"Content-type": "application/json"};

      var response = await http.get(url);

      Map<String, dynamic> userMap = convert.json.decode(response.body);

      User user = User.fromJson(userMap);
      
      return user;
  }

  static Future<List<UserAppointment>> getUserServices(int id) async {
     Uri url =
          Uri.parse('http://localhost:3333/users/$id/services');

      Map<String, String> headers = {"Content-type": "application/json"};

      var response = await http.get(url, headers: headers);

      List<dynamic> list = convert.json.decode(response.body);

    final List<UserAppointment> userAppointments =
        list.map((userAppointment) => UserAppointment.fromJson(userAppointment)).toList();

      return userAppointments;
  }
}
