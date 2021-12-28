import 'package:limpamais_application/models/user.dart';

import 'diarist.dart';

class Service {
  int? id;
  String? appointmentDate;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? diaristId;
  int? userId;
  User? user;
  Diarist? diarist;

  Service(
      {this.id,
      this.appointmentDate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.diaristId,
      this.userId,
      this.user,
      this.diarist});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentDate = json['appointment_date'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    diaristId = json['diarist_id'];
    userId = json['user_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    diarist =
        json['diarist'] != null ? new Diarist.fromJson(json['diarist']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointment_date'] = this.appointmentDate;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['diarist_id'] = this.diaristId;
    data['user_id'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user?.toJson();
    }
    if (this.diarist != null) {
      data['diarist'] = this.diarist?.toJson();
    }
    return data;
  }
}