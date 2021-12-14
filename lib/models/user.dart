import 'dart:convert' as convert;

import 'package:limpamais_application/utils/prefs.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? urlPhoto;

  User({this.id, this.name, this.email, this.phone, this.urlPhoto});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    urlPhoto = json['url_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
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
