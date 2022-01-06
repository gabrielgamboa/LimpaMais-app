import 'package:limpamais_application/models/user.dart';
import 'package:limpamais_application/pages/login_page.dart';
import 'package:limpamais_application/pages/user/user_appointments.dart';
import 'package:limpamais_application/pages/user/user_profile.dart';
import 'package:limpamais_application/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  late User? user;

  @override
  Widget build(BuildContext context) {
    final userFuture = User.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            FutureBuilder(
                future: userFuture,
                builder: (context, snapshot) {
                  User? user = snapshot.data as User?;
                  this.user = user;
                  return user != null ? _drawerHeader(user) : Container();
                }),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Meu perfil"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickProfile(context),
            ),
            ListTile(
              leading: Icon(Icons.schedule_outlined),
              title: Text("Meus agendamentos"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickAppointments(context),
            ),
            ListTile(
              leading: Icon(Icons.star_outline),
              title: Text("Avaliações"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
              },
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

  UserAccountsDrawerHeader _drawerHeader(User user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.name!),
      accountEmail: Text(user.email!),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.urlPhoto ?? "https://www.pikpng.com/pngl/m/80-805523_default-avatar-svg-png-icon-free-download-264157.png"),
        // backgroundImage: user.urlPhoto!.isEmpty ? NetworkImage("https://www.pikpng.com/pngl/m/80-805523_default-avatar-svg-png-icon-free-download-264157.png") : NetworkImage(user.urlPhoto!),
      ),
    );
  }

  void _onClickProfile(BuildContext context) { 
    push(context, UserProfile(id: user!.id!,));
  }

  void _onClickAppointments(BuildContext context) {
    push(context, UserAppointmentsPage(userId: user?.id,));
  }

  void _onClickLogout(BuildContext context) {
    User.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
