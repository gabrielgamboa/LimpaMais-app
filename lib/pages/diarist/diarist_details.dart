import 'package:flutter/material.dart';
import 'package:limpamais_application/models/diarist.dart';

class DiaristDetails extends StatefulWidget {
  late final Diarist diarist;

  
  DiaristDetails({required this.diarist});

  @override
  _DiaristDetailsState createState() => _DiaristDetailsState();
}

class _DiaristDetailsState extends State<DiaristDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detalhes"),
      ),
    );
  }
}
