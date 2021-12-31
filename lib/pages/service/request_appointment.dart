import 'package:flutter/material.dart';
import 'package:limpamais_application/pages/home_page.dart';
import 'package:limpamais_application/widgets/app_button.dart';
import 'package:limpamais_application/widgets/text_info.dart';

class RequestAppointment extends StatefulWidget {
  const RequestAppointment({ Key? key }) : super(key: key);

  @override
  _RequestAppointmentState createState() => _RequestAppointmentState();
}

class _RequestAppointmentState extends State<RequestAppointment> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
            Align(alignment: Alignment.centerLeft, child: TextInfo(text: "Selecione o dia desejado", fontSize: 20,),),
            // Row(children: [
            //   IconButton(icon: Icon(Icons.calendar_today_outlined), onPressed: () => _selectDate(context), ),
            //   Text("${selectedDate}"),
            // ],),
            SizedBox(height: 10.0,),

            CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: DateTime(2015, 8),
              lastDate: DateTime(2101), 
              onDateChanged: (DateTime value) {  },),
            SizedBox(height: 20.0,),
            AppButton("Confirmar solicitação", onPressed: () => const HomePage())
          ],
        ),
      ),
    );
  }
}