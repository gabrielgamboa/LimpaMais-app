import 'package:limpamais_application/widgets/drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("LimpaMais"),
      ),
      body: _body(context),
      drawer: DrawerList(),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 350,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Pesquisa por cidades..."
                    ),
                  ),
                ),
                SizedBox(width: 26,),
                FloatingActionButton(onPressed: () {}, child: Icon(Icons.search),)
              ],
            ),
            Container(
              height: 450,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
