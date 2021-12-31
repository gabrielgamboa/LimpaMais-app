import 'package:limpamais_application/api/diarist/diarist_api.dart';
import 'package:limpamais_application/pages/diarist/diarist_details.dart';
import 'package:limpamais_application/utils/nav.dart';
import 'package:limpamais_application/widgets/drawer_list.dart';
import 'package:limpamais_application/models/diarist.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
      diarists = diaristsList;
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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 220,
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Pesquisa por cidades..."),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              FloatingActionButton(
                onPressed: () => _loadDiarists(),
                child: const Icon(Icons.search),
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
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (diarists!.isEmpty) {
      return const Center(
        child: Text(
          "Não foram encontradas diaristas.",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      child: ListView.builder(
          itemCount: diarists!.length,
          itemBuilder: (context, index) {
            Diarist diarist = diarists![index];

            return Card(
              color: Colors.grey[100],
              child: Container(
                padding: const EdgeInsets.all(16),
                child: ListTile(
                  leading: Image.network(diarist.urlPhoto ?? "https://www.pikpng.com/pngl/m/80-805523_default-avatar-svg-png-icon-free-download-264157.png"),
                  title: Text(diarist.name!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${diarist.city}, ${diarist.state}", overflow:TextOverflow.ellipsis,),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text("R\$${diarist.dailyRate}")
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    push(
                        context,
                        DiaristDetailsPage(
                          diarist: diarist,
                        ));
                  },
                ),
              ),
            );
          }),
    );
  }

  _onClickCarro(Diarist diarist) {}
}
