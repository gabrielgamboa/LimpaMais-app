import 'package:flutter/material.dart';
import 'package:limpamais_application/api/user/user_api.dart';
import 'package:limpamais_application/models/user.dart';
import 'package:limpamais_application/models/user_appointments.dart';
import 'package:limpamais_application/pages/service/request_appointment.dart';
import 'package:limpamais_application/utils/nav.dart';
import 'package:limpamais_application/widgets/app_button.dart';
import 'package:limpamais_application/widgets/text_info.dart';

class UserAppointmentsPage extends StatefulWidget {
  final int? userId;

  const UserAppointmentsPage({Key? key, required this.userId}) : super(key: key);

  @override
  _UserAppointmentsPageState createState() => _UserAppointmentsPageState();
}

class _UserAppointmentsPageState extends State<UserAppointmentsPage> {
  List<UserAppointment>? userAppointments;

  @override
  void initState() {
    super.initState();
    _loadUserAppointments();
  }

  void _loadUserAppointments() async {
    List<UserAppointment>? userAppointmentsInfos = await UserApi.getUserServices(widget.userId!);

    setState(() {
      userAppointments = userAppointmentsInfos;
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
    if (userAppointments == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }


    // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       Container(
    //         width: MediaQuery.of(context).size.width,
    //         padding:
    //             const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    //         child: Column(
    //           children: [
    //             Align(
    //                 alignment: Alignment.centerLeft,
    //                 child: Text(
    //                   "Confirmados:",
    //                   style: TextStyle(fontSize: 22),
    //                 )),
    //             SizedBox(
    //               height: 5,
    //             ),
    //             SizedBox(
    //               height: 10,
    //             ),
                
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Column(
        children: [
          const Text(
            "Confirmados:",
            style: TextStyle(fontSize: 22),
          ),
          ListView.builder(
              itemCount: userAppointments!.length,
              itemBuilder: (context, index) {
                UserAppointment userAppointmentInfos = userAppointments![index];

                return Card(
                  color: Colors.grey[100],
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: ListTile(
                      leading: Image.network(userAppointmentInfos.diarist!.urlPhoto ?? "https://www.pikpng.com/pngl/m/80-805523_default-avatar-svg-png-icon-free-download-264157.png"),
                      title: Text(userAppointmentInfos.diarist!.name!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${userAppointmentInfos.diarist!.city}, ${userAppointmentInfos.diarist!.state}", overflow:TextOverflow.ellipsis,),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text("R\$${userAppointmentInfos.diarist!.dailyRate}")
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                       
                      },
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
  
}
