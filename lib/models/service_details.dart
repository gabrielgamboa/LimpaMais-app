import 'package:limpamais_application/models/user.dart';

class ServiceDetails {
  int? id;
  String? appointmentDate;
  String? status;
  User? user;

  ServiceDetails({this.id, this.appointmentDate, this.status, this.user});

  ServiceDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appointmentDate = json['appointment_date'];
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = this.id;
    data['appointment_date'] = this.appointmentDate;
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}