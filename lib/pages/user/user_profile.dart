import 'package:flutter/material.dart';
import 'package:limpamais_application/api/user/user_api.dart';
import 'package:limpamais_application/models/user.dart';

class UserProfile extends StatefulWidget {
  final int id;

  const UserProfile({ Key? key, required this.id }) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User? user;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async{
    User user = await UserApi.getUser(widget.id);

    setState(() {
      this.user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Meu perfil"),
      ),
      body: _body(),
    );
  }


  Widget _body() {
    if (user == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return CircleAvatar(backgroundImage: NetworkImage(user!.urlPhoto!),);
  }

}