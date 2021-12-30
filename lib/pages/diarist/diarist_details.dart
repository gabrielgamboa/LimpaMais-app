import 'package:flutter/material.dart';
import 'package:limpamais_application/api/diarist/diarist_api.dart';
import 'package:limpamais_application/models/diarist.dart';
import 'package:limpamais_application/models/diarist_details.dart';
import 'package:limpamais_application/widgets/text_info.dart';

class DiaristDetailsPage extends StatefulWidget {
  final Diarist diarist;
  
  const DiaristDetailsPage({Key? key, required this.diarist}) : super(key: key);

  @override
  _DiaristDetailsPageState createState() => _DiaristDetailsPageState();
}

class _DiaristDetailsPageState extends State<DiaristDetailsPage> {
  DiaristDetails? diaristInfos;


  @override
  void initState() {
    super.initState();
    _loadDiaristDetails();
  }

  void _loadDiaristDetails() async {
    int diaristId = widget.diarist.id!;
    DiaristDetails diaristDetails = await DiaristsApi.getDiaristDetails(diaristId);

    setState(() {
      diaristInfos = diaristDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detalhes"),
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
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(diaristInfos!.urlPhoto ?? "https://www.pikpng.com/pngl/m/80-805523_default-avatar-svg-png-icon-free-download-264157.png"),
              radius: 60,
            ),
            SizedBox(height: 5,),
            TextInfo(text: diaristInfos!.name!),
            SizedBox(height: 5,),
            TextInfo(text: "${diaristInfos!.city!}, ${diaristInfos!.state!}"),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.star),
              TextInfo(text: diaristInfos!.averageRate!)
            ],),
            SizedBox(height: 5,),
            TextInfo(text: "Valor: R\$${diaristInfos!.dailyRate!},00"),
          ],
        ),
      ),
    );
  }
}
