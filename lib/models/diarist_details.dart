import 'package:limpamais_application/models/rating.dart';

class DiaristDetails {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? street;
  String? number;
  String? city;
  String? averageRate;
  String? state;
  int? dailyRate;
  String? note;
  String? urlPhoto;
  List<Rating>? ratings;

  DiaristDetails(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.street,
      this.number,
      this.city,
      this.averageRate,
      this.state,
      this.dailyRate,
      this.note,
      this.urlPhoto,
      this.ratings});

  DiaristDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    street = json['street'];
    number = json['number'];
    city = json['city'];
    averageRate = json['average_rate'];
    state = json['state'];
    dailyRate = json['daily_rate'];
    note = json['note'];
    urlPhoto = json['url_photo'];
    if (json['ratings'] != null) {
      ratings = <Rating>[];
      json['ratings'].forEach((v) {
        ratings?.add(new Rating.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['street'] = this.street;
    data['number'] = this.number;
    data['city'] = this.city;
    data['average_rate'] = this.averageRate;
    data['state'] = this.state;
    data['daily_rate'] = this.dailyRate;
    data['note'] = this.note;
    data['url_photo'] = this.urlPhoto;
    data['ratings'] = this.ratings?.map((v) => v.toJson()).toList();
    return data;
  }
}
