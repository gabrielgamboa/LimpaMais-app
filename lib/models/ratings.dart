import 'package:limpamais_application/models/user.dart';

class Ratings {
  int? id;
  User? user;
  int? rate;
  String? description;
  String? createdAt;

  Ratings({required this.id, required this.user, required this.rate, required this.description, required this.createdAt});

  Ratings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    rate = json['rate'];
    description = json['description'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user!.toJson();
    data['rate'] = this.rate;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    return data;
  }
}