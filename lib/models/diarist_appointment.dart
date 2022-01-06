import 'package:limpamais_application/models/user.dart';

class DiaristAppointment {
  int? id;
  String? appointmentDate;
  String? status;
  String? createdAt;
  String? updatedAt;
  User? user;

  DiaristAppointment(
      {this.id,
      this.appointmentDate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.user});

  DiaristAppointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentDate = json['appointment_date'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appointment_date'] = this.appointmentDate;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}