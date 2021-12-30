import 'dart:convert' as convert;

import 'package:limpamais_application/utils/prefs.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? street;
  String? number;
  String? city;
  String? state;
  String? password;
  String? urlPhoto;

  User(
      {
      this.id,
      this.name,
      this.email,
      this.phone,
      this.street,
      this.number,
      this.city,
      this.state,
      this.password,
      this.urlPhoto});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    street = json['street'];
    number = json['number'];
    city = json['city'];
    state = json['state'];
    password = json['password'];
    urlPhoto = json['url_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['street'] = this.street;
    data['number'] = this.number;
    data['city'] = this.city;
    data['state'] = this.state;
    data['password'] = this.password;
    data['url_photo'] = this.urlPhoto;
    return data;
  }

   static void clear() {
    Prefs.setString("user.prefs", "");
  }

  void save() {
    Map map = toJson();
    String json = convert.json.encode(map);
    Prefs.setString("user.prefs", json);
  }

  static Future<User?> get() async {
    String userJson = await Prefs.getString("user.prefs");

    if (userJson.isEmpty) {
      return null;
    }

    Map<String, dynamic> userMap = convert.json.decode(userJson);
    User user = User.fromJson(userMap);
    return user;
  }
}


