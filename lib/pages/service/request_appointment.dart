import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:limpamais_application/api/api_response.dart';
import 'package:limpamais_application/api/service/service_api.dart';
import 'package:limpamais_application/pages/home_page.dart';
import 'package:limpamais_application/utils/alert.dart';
import 'package:limpamais_application/utils/nav.dart';
import 'package:limpamais_application/widgets/app_button.dart';
import 'package:limpamais_application/widgets/text_info.dart';

class RequestAppointment extends StatefulWidget {
  final int diaristId;
  final int userId;

  const RequestAppointment({Key? key, required this.diaristId, required this.userId}) : super(key: key);

  @override
  _RequestAppointmentState createState() => _RequestAppointmentState();
}

class _RequestAppointmentState extends State<RequestAppointment> {
  DateTime selectedDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Solicitar agendamento"),
      ),
      body: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextInfo(
                text: "Selecione o dia desejado",
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              child: CalendarDatePicker(
                initialDate: selectedDate,
                firstDate: DateTime(2015, 8),
                lastDate: DateTime(2101),
                onDateChanged: (DateTime value) {
                  setState(() {
                    selectedDate = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            AppButton("Confirmar solicitação",
                onPressed: () => _confirmRequest(context))
          ],
        ),
      ),
    );
  }



  void _confirmRequest(BuildContext context) async {
    //abrir modal dizendo sucesso e retornando pra home
    DateFormat dateFormat = DateFormat("MM-dd-yyyy");
    String appointmentDate = dateFormat.format(selectedDate);

    ApiResponse response = await ServiceApi.createService(widget.userId, widget.diaristId, appointmentDate);

    if (response.ok!) {
      push(context, const HomePage());
      alert(context, response.result);
    }


  }
}
