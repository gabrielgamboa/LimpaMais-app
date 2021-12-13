import 'package:limpamais_application/api/diarist/diarist_api.dart';
import 'package:limpamais_application/pages/diarist/diarist_details.dart';
import 'package:limpamais_application/utils/nav.dart';
import 'package:limpamais_application/widgets/drawer_list.dart';
import 'package:limpamais_application/models/diarist.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Diarist>? diarists;

  @override
  void initState() {
    super.initState();
    _loadDiarists();
  }

  void _loadDiarists() async {
    List<Diarist> diaristsList = await DiaristsApi.getDiarists();
    setState(() {
      this.diarists = diaristsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("LimpaMais"),
      ),
      body: _body(context),
      drawer: DrawerList(),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      // padding: EdgeInsets.only(top: 32.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 220,
                child: TextFormField(
                  decoration:
                      InputDecoration(hintText: "Pesquisa por cidades..."),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.search),
              )
            ],
          ),
          Expanded(child: _listView()),
        ],
      ),
    );
  }

  Widget _listView() {
    if (diarists == null) {
      return Container(
        height: 400,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(top: 16.0),
      child: ListView.builder(
          itemCount: diarists!.length,
          itemBuilder: (context, index) {
            Diarist diarist = diarists![index];

            return Card(
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.all(16),
                child: ListTile(
                  leading: Image.asset("assets/images/avatar.png"),
                  title: Text(diarist.name!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${diarist.city}, ${diarist.state}"),
                      SizedBox(height: 12.0,),
                      Text("R\$ ${diarist.dailyRate}")
                    ],
                  ),

                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    push(context, DiaristDetails(diarist: diarist,));
                  },
                ),
              ),
            );

            // return Card(
            //   color: Colors.grey[100],
            //   child: Container(
            //     padding: EdgeInsets.all(16),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Center(
            //             child: Image.asset(
            //           "assets/images/avatar.png",
            //           width: 50,
            //         )),

            //         Text(
            //           diarist.name!,
            //           maxLines: 1,
            //           overflow: TextOverflow.ellipsis,
            //           style: TextStyle(fontSize: 25),
            //         ),
            //         Text(
            //           "descrição",
            //           style: TextStyle(fontSize: 16),
            //         ),
            //       ],
            //     ),
            //   ),
            // );
          }),
    );
  }

  _onClickCarro(Diarist diarist) {}
}
