import 'package:flutter/material.dart';
import 'package:limpamais_application/api/diarist/diarist_api.dart';
import 'package:limpamais_application/api/user/user_api.dart';
import 'package:limpamais_application/models/diarist_appointment.dart';
import 'package:limpamais_application/models/user.dart';
import 'package:limpamais_application/models/user_appointments.dart';
import 'package:limpamais_application/pages/service/request_appointment.dart';
import 'package:limpamais_application/pages/service/service_details_page.dart';
import 'package:limpamais_application/utils/nav.dart';
import 'package:limpamais_application/widgets/app_button.dart';
import 'package:limpamais_application/widgets/diarist/diarist_drawer_list.dart';
import 'package:limpamais_application/widgets/text_info.dart';
import 'package:intl/intl.dart';

class DiaristHomePage extends StatefulWidget {
  final int? diaristId;

  const DiaristHomePage({Key? key, required this.diaristId}) : super(key: key);

  @override
  _DiaristHomePageState createState() => _DiaristHomePageState();
}

class _DiaristHomePageState extends State<DiaristHomePage> {
  List<DiaristAppointment>? diaristAppointmentsConfirmed;
  List<DiaristAppointment>? diaristAppointmentsToBeConfirmed;

  @override
  void initState() {
    super.initState();
    _loadDiaristAppointments();
  }

  void _loadDiaristAppointments() async {
    List<DiaristAppointment>? diaristAppointments =
        await DiaristsApi.getUserServices(widget.diaristId!);

    List<DiaristAppointment>? confirmedAppointments = diaristAppointments
        .where((userAppointment) =>
            userAppointment.status!.contains("scheduled and not rated"))
        .toList();

    List<DiaristAppointment>? toBeConfirmedAppointments = diaristAppointments
        .where((userAppointment) => userAppointment.status!.contains("created"))
        .toList();

    setState(() {
      diaristAppointmentsConfirmed = confirmedAppointments;
      diaristAppointmentsToBeConfirmed = toBeConfirmedAppointments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("LimpaMais"),
      ),
      drawer: DiaristDrawer(),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    if (diaristAppointmentsConfirmed == null ||
        diaristAppointmentsToBeConfirmed == null) {
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
              "Meus agendamentos:",
              style: TextStyle(fontSize: 22),
            ),
          ),
          diaristAppointmentsConfirmed!.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: diaristAppointmentsConfirmed!.length,
                      itemBuilder: (context, index) {
                        DiaristAppointment diaristAppointmentInfos =
                            diaristAppointmentsConfirmed![index];

                        final String appointmentDate = _formatAppointmentDate(
                            diaristAppointmentInfos.appointmentDate!);

                        return Card(
                          color: Colors.grey[100],
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: ListTile(
                              leading: Image.network(diaristAppointmentInfos
                                      .user!.urlPhoto ??
                                  "https://www.pikpng.com/pngl/m/80-805523_default-avatar-svg-png-icon-free-download-264157.png"),
                              title: Text(diaristAppointmentInfos.user!.name!),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${diaristAppointmentInfos.user!.city}, ${diaristAppointmentInfos.user!.state}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(diaristAppointmentInfos.user!.phone!),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Text(appointmentDate)
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
              child: diaristAppointmentsToBeConfirmed!.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: diaristAppointmentsToBeConfirmed!.length,
                      itemBuilder: (context, index) {
                        DiaristAppointment userAppointmentInfos =
                            diaristAppointmentsToBeConfirmed![index];

                        final String appointmentDate = _formatAppointmentDate(
                            userAppointmentInfos.appointmentDate!);

                        return Card(
                          color: Colors.grey[100],
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: ListTile(
                              leading: Image.network(userAppointmentInfos
                                      .user!.urlPhoto ??
                                  "https://www.pikpng.com/pngl/m/80-805523_default-avatar-svg-png-icon-free-download-264157.png"),
                              title: Text(userAppointmentInfos.user!.name!),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${userAppointmentInfos.user!.city}, ${userAppointmentInfos.user!.state}",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(userAppointmentInfos.user!.phone!),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Text(appointmentDate)
                                ],
                              ),
                              trailing: const Icon(Icons.arrow_forward),
                              onTap: () => _onClickAppointment(context, userAppointmentInfos),
                            ),
                          ),
                        );
                      })
                  : const TextInfo(
                      text: 'Sem confirmações necessárias',
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

  void _onClickAppointment(BuildContext context, DiaristAppointment userAppointmentInfos) {
    push(context, ServiceDetailsPage(serviceId: userAppointmentInfos.id!,));
  }
}
