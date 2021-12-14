import 'package:limpamais_application/models/user.dart';
import 'package:limpamais_application/pages/login_page.dart';
import 'package:limpamais_application/utils/defaultUserProfilePic.dart';
import 'package:limpamais_application/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<User?> userFuture = User.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            FutureBuilder(
                future: userFuture,
                builder: (context, snapshot) {
                  User? user = snapshot.data as User?;
                  return user != null ? _drawerHeader(user) : Container();
                }),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Meu perfil"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("1");
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule_outlined),
              title: Text("Meus agendamentos"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("1");
              },
            ),
            ListTile(
              leading: Icon(Icons.star_outline),
              title: Text("Avaliações"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("1");
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
        backgroundImage: user.urlPhoto == null ? NetworkImage(defaultUserProfilePic) : NetworkImage(user.urlPhoto!),
      ),
    );
  }

  void _onClickLogout(BuildContext context) {
    User.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
