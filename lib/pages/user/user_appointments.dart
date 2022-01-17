import 'package:flutter/material.dart';
import 'package:limpamais_application/api/user/user_api.dart';
import 'package:limpamais_application/models/user.dart';
import 'package:limpamais_application/models/user_appointments.dart';
import 'package:limpamais_application/pages/service/request_appointment.dart';
import 'package:limpamais_application/utils/nav.dart';
import 'package:limpamais_application/widgets/app_button.dart';
import 'package:limpamais_application/widgets/text_info.dart';
import 'package:intl/intl.dart';

class UserAppointmentsPage extends StatefulWidget {
  final int? userId;

  const UserAppointmentsPage({Key? key, required this.userId})
      : super(key: key);

  @override
  _UserAppointmentsPageState createState() => _UserAppointmentsPageState();
}

class _UserAppointmentsPageState extends State<UserAppointmentsPage> {
  List<UserAppointment>? userAppointmentsConfirmed;
  List<UserAppointment>? userAppointmentsToBeConfirmed;

  @override
  void initState() {
    super.initState();
    _loadUserAppointments();
  }

  void _loadUserAppointments() async {
    List<UserAppointment>? userAppointments =
        await UserApi.getUserServices(widget.userId!);

    List<UserAppointment>? confirmedAppointments = userAppointments
        .where((userAppointment) =>
            userAppointment.status!.contains("scheduled and not rated"))
        .toList();

    List<UserAppointment>? toBeConfirmedAppointments = userAppointments
        .where((userAppointment) => userAppointment.status!.contains("created"))
        .toList();

    setState(() {
      userAppointmentsConfirmed = confirmedAppointments;
      userAppointmentsToBeConfirmed = toBeConfirmedAppointments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Agendamentos"),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    if (userAppointmentsConfirmed == null ||
        userAppointmentsToBeConfirmed == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: ListView(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Confirmados:",
              style: TextStyle(fontSize: 22),
            ),
          ),
          userAppointmentsConfirmed!.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userAppointmentsConfirmed!.length,
                      itemBuilder: (context, index) {
                        UserAppointment userAppointmentInfos =
                            userAppointmentsConfirmed![index];

                        final String appointmentDate = _formatAppointmentDate(
                            userAppointmentInfos.appointmentDate!);

                        return Card(
                          color: Colors.grey[100],
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: ListTile(
                              leading: Image.network(userAppointmentInfos
                                      .diarist!.urlPhoto ??
                                  "https://www.pikpng.com/pngl/m/80-805523_default-avatar-svg-png-icon-free-download-264157.png"),
                              title: Text(userAppointmentInfos.diarist!.name!),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${userAppointmentInfos.diarist!.city}, ${userAppointmentInfos.diarist!.state}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(userAppointmentInfos.diarist!.phone!),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "R\$${userAppointmentInfos.diarist!.dailyRate}"),
                                      Text(appointmentDate)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }))
              : const TextInfo(
                  text: 'Sem agendamentos confirmados',
                ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "A confirmar:",
              style: TextStyle(fontSize: 22),
            ),
          ),
          Expanded(
              child: userAppointmentsToBeConfirmed!.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userAppointmentsToBeConfirmed!.length,
                      itemBuilder: (context, index) {
                        UserAppointment userAppointmentInfos =
                            userAppointmentsToBeConfirmed![index];

                        final String appointmentDate = _formatAppointmentDate(
                            userAppointmentInfos.appointmentDate!);

                        return Card(
                          color: Colors.grey[100],
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: ListTile(
                              leading: Image.network(userAppointmentInfos
                                      .diarist!.urlPhoto ??
                                  "https://www.pikpng.com/pngl/m/80-805523_default-avatar-svg-png-icon-free-download-264157.png"),
                              title: Text(userAppointmentInfos.diarist!.name!),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${userAppointmentInfos.diarist!.city}, ${userAppointmentInfos.diarist!.state}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(userAppointmentInfos.diarist!.phone!),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "R\$${userAppointmentInfos.diarist!.dailyRate}"),
                                      Text(appointmentDate),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : const TextInfo(
                      text: 'Sem agendamentos confirmados',
                    )),
        ],
      ),
    );
  }

  String _formatAppointmentDate(String data) {
    final appointmentDate =
        DateFormat("dd/MM/yyyy").format(DateTime.parse(data));

    return appointmentDate;
  }
}
