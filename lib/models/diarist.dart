import 'dart:convert' as convert;
import 'package:limpamais_application/utils/prefs.dart';

class Diarist {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? street;
  String? number;
  String? city;
  String? state;
  double? dailyRate;
  String? note;
  String? password;
  String? urlPhoto;

  Diarist(
      {
      this.id,
      this.name,
      this.email,
      this.phone,
      this.street,
      this.number,
      this.city,
      this.state,
      this.dailyRate,
      this.note,
      this.password,
      this.urlPhoto});

  Diarist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    street = json['street'];
    number = json['number'];
    city = json['city'];
    state = json['state'];
    dailyRate = json['daily_rate'].toDouble();
    note = json['note'];
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
    data['daily_rate'] = this.dailyRate;
    data['note'] = this.note;
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
    Prefs.setString("diarist.prefs", json);
  }

  static Future<dynamic?> get() async {
    String diaristJson = await Prefs.getString("diarist.prefs");

    if (diaristJson.isEmpty) {
      return null;
    }

    Map<String, dynamic> userMap = convert.json.decode(diaristJson);
    Diarist diarist = Diarist.fromJson(userMap);
    return diarist;
  }
}