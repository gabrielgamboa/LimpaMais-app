import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:limpamais_application/models/user.dart';

class UserApi {
  static Future<User> getUser(int id) async {
      Uri url =
          Uri.parse('http://10.0.2.2:3333/users/$id');

      Map<String, String> headers = {"Content-type": "application/json"};

      var response = await http.get(url);

      Map<String, dynamic> userMap = convert.json.decode(response.body);

      User user = User.fromJson(userMap);
      
      return user;
  }
}