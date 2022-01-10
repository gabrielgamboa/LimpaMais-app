import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:limpamais_application/api/api_response.dart';
import 'package:limpamais_application/api/service/service_api.dart';
import 'package:limpamais_application/models/service_details.dart';
import 'package:limpamais_application/widgets/text_info.dart';

class ServiceDetailsPage extends StatefulWidget {
  final int serviceId;

  const ServiceDetailsPage({Key? key, required this.serviceId})
      : super(key: key);

  @override
  _ServiceDetailsPageState createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  late final ServiceDetails serviceDetails;

  @override
  void initState() {
    super.initState();
    _loadServiceDetails();
  }

  void _loadServiceDetails() async {
    final response = await ServiceApi.getServiceById(widget.serviceId);

    setState(() {
      serviceDetails = response.result!;
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
    ); //criar interface
  }

  Widget _body(BuildContext context) {
    if (serviceDetails == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(children: [
          CircleAvatar(child: Image.network(serviceDetails.user?.urlPhoto ?? "https://www.pikpng.com/pngl/m/80-805523_default-avatar-svg-png-icon-free-download-264157.png"), radius: 60,),
          TextInfo(text: serviceDetails.user!.name!),
          SizedBox(height: 5,),
          TextInfo(text: "${serviceDetails.user!.city!}, ${serviceDetails.user!.state!}"),
          SizedBox(height: 5,),
          TextInfo(text: serviceDetails.user!.street!),
          SizedBox(height: 5,),
          TextInfo(text: serviceDetails.user!.street!),
          SizedBox(height: 5,),
          TextInfo(text: serviceDetails.user!.phone!),
          SizedBox(height: 5,),
          TextInfo(text: DateFormat("dd/MM/yyyy").format(DateTime.parse(serviceDetails.appointmentDate!))),
          SizedBox(height: 22,),
          Row(children: [],)

        ]));
  }
}
