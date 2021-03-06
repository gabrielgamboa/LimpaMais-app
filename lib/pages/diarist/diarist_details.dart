import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:limpamais_application/api/diarist/diarist_api.dart';
import 'package:limpamais_application/models/diarist.dart';
import 'package:limpamais_application/models/diarist_details.dart';
import 'package:limpamais_application/models/rating.dart';
import 'package:limpamais_application/models/user.dart';
import 'package:limpamais_application/pages/service/request_appointment.dart';
import 'package:limpamais_application/utils/nav.dart';
import 'package:limpamais_application/widgets/app_button.dart';
import 'package:limpamais_application/widgets/text_info.dart';

class DiaristDetailsPage extends StatefulWidget {
  final Diarist diarist;

  const DiaristDetailsPage({Key? key, required this.diarist}) : super(key: key);

  @override
  _DiaristDetailsPageState createState() => _DiaristDetailsPageState();
}

class _DiaristDetailsPageState extends State<DiaristDetailsPage> {
  DiaristDetails? diaristInfos;
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  @override
  void initState() {
    super.initState();
    _loadDiaristDetails();
  }

  void _loadDiaristDetails() async {
    int diaristId = widget.diarist.id!;
    DiaristDetails diaristDetails =
        await DiaristsApi.getDiaristDetails(diaristId);

    setState(() {
      diaristInfos = diaristDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Detalhes"),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    if (diaristInfos == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(diaristInfos!.urlPhoto ??
                      "https://www.pikpng.com/pngl/m/80-805523_default-avatar-svg-png-icon-free-download-264157.png"),
                  radius: 60,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextInfo(text: diaristInfos!.name!),
                const SizedBox(
                  height: 5,
                ),
                TextInfo(
                    text: "${diaristInfos!.city!}, ${diaristInfos!.state!}"),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star),
                    TextInfo(text: diaristInfos!.averageRate!)
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextInfo(text: "Valor: R\$${diaristInfos!.dailyRate!}"),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 24.0),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Detalhes:",
                      style: TextStyle(fontSize: 22),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextInfo(
                      text: diaristInfos!.note ??
                          "Essa diarista n??o possui detalhes."),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Avalia????es:",
                      style: TextStyle(fontSize: 22),
                    )),
                const SizedBox(
                  height: 5,
                ),
                _loadRatings(),
                const SizedBox(
                  height: 10,
                ),
                AppButton("Solicitar agendamento",
                    onPressed: () => _requestAppointment()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _loadRatings() {
    return diaristInfos!.ratings!.isEmpty
        ? const TextInfo(text: "Essa diarista n??o possui avalia????es")
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) => const SizedBox(
              height: 10,
            ),
            itemCount: diaristInfos!.ratings!.length,
            itemBuilder: (BuildContext context, int index) {
              Rating rating = diaristInfos!.ratings![index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextInfo(text: rating.user!.name!),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star),
                              TextInfo(text: "${rating.rate}"),
                            ],
                          ),
                          TextInfo(text: dateFormat.format(DateTime.parse(rating.createdAt!)))
                        ],
                      ),
                      TextInfo(text: rating.description!)
                    ],
                  ),
                ),
              );
            },
          );
  }

  void _requestAppointment() async {
    User? user = await User.get();
    push(
        context,
        RequestAppointment(
          diaristId: diaristInfos!.id!,
          userId: user!.id!,
        ));
  }
}
