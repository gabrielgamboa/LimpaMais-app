import 'package:limpamais_application/models/diarist.dart';
import 'package:limpamais_application/models/user.dart';
import 'package:limpamais_application/pages/login_page.dart';
import 'package:limpamais_application/pages/user/user_appointments.dart';
import 'package:limpamais_application/pages/user/user_profile.dart';
import 'package:limpamais_application/utils/nav.dart';
import 'package:flutter/material.dart';

class DiaristDrawer extends StatelessWidget {
  late Diarist? diarist;

  @override
  Widget build(BuildContext context) {
    final diaristFuture = Diarist.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            FutureBuilder(
                future: diaristFuture,
                builder: (context, snapshot) {
                  Diarist? diarist = snapshot.data as Diarist?;
                  this.diarist = diarist;
                  return diarist != null ? _drawerHeader(diarist) : Container();
                }),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Meu perfil"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickProfile(context),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Sair"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader _drawerHeader(Diarist diarist) {
    return UserAccountsDrawerHeader(
      accountName: Text(diarist.name!),
      accountEmail: Text(diarist.email!),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(diarist.urlPhoto ?? "https://www.pikpng.com/pngl/m/80-805523_default-avatar-svg-png-icon-free-download-264157.png"),
      ),
    );
  }

  void _onClickProfile(BuildContext context) { 
    push(context, UserProfile(id: diarist!.id!,));
  }

  void _onClickLogout(BuildContext context) {
    Diarist.clear();
    Navigator.pop(context);
    push(context, const LoginPage(), replace: true);
  }
}
