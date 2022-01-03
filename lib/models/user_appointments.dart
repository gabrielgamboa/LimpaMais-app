import 'package:limpamais_application/models/diarist.dart';
import 'package:limpamais_application/models/rating.dart';

class UserAppointment {
  int? id;
  String? appointmentDate;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? diaristId;
  int? userId;
  Diarist? diarist;
  Rating? rating;

  UserAppointment(
      {this.id,
      this.appointmentDate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.diaristId,
      this.userId,
      this.diarist,
      this.rating});

  UserAppointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentDate = json['appointment_date'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    diaristId = json['diarist_id'];
    userId = json['user_id'];
    diarist =
        json['diarist'] != null ? new Diarist.fromJson(json['diarist']) : null;
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
  }
}
