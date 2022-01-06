import 'package:limpamais_application/api/api_response.dart';
import 'package:limpamais_application/api/login/login_api.dart';
import 'package:limpamais_application/models/diarist.dart';
import 'package:limpamais_application/models/user.dart';
import 'package:limpamais_application/pages/diarist/diarist_home_page.dart';
import 'package:limpamais_application/utils/alert.dart';
import 'package:limpamais_application/utils/snackAlert.dart';
import 'package:flutter/material.dart';

import 'package:limpamais_application/utils/nav.dart';
import 'package:limpamais_application/pages/home_page.dart';
import 'package:limpamais_application/widgets/app_button.dart';
import 'package:limpamais_application/widgets/app_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _tLogin = TextEditingController();
  final _tPassword = TextEditingController();
  final _focusSenha = FocusNode();

  bool _showProgress = false;

  @override
  void initState() {
    super.initState();

    Future<dynamic?> user = User.get();

    user.then((dynamic user) {
      if (user != null) {
        if (user is User) {
          push(context, const HomePage(), replace: true);
        } else {
          push(context, DiaristHomePage(diaristId: user.id), replace: true);
        }
      }
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          "assets/images/background.png",
          fit: BoxFit.fill,
        ),
      ),
      Container(
        color: Colors.black.withOpacity(0.6),
      ),
      SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 210,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        //passa o nextFocus indicando qual foco ir
                        AppText("E-mail",
                            controller: _tLogin,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            nextFocus: _focusSenha,
                            validator: _validateEmail),
                        const SizedBox(
                          height: 10,
                        ),
                        // passa o focusNode o seu foco
                        AppText("Senha",
                            controller: _tPassword,
                            focusNode: _focusSenha,
                            validator: _validatePassword,
                            password: true),
                        const SizedBox(
                          height: 20,
                        ),
                        AppButton(
                          'Entrar',
                          onPressed: _onClickLogin,
                          showProgress: _showProgress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: const Text("Criar uma nova conta",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  void _onClickLogin() async {
    bool formOk = _formKey.currentState!.validate();

    if (!formOk) {
      return;
    }

    String email = _tLogin.text;
    String password = _tPassword.text;

    setState(() {
      _showProgress = true;
    });

    ApiResponse response = await LoginApi.login(email, password);

    if (response.ok!) {
      dynamic user = response.result;

      if (user is Diarist) {
        push(
            context,
            DiaristHomePage(
              diaristId: user.id,
            ),
            replace: true);
      } else {
        push(context, const HomePage(), replace: true);
      }

      snackAlert(context, "Bem vindo, ${user.name}!");
    } else {
      alert(context, response.message!);
    }

    setState(() {
      _showProgress = false;
    });
  }

  String? _validateEmail(String? text) {
    if (text!.isEmpty) {
      return "Por favor, preencha o campo.";
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(text)) {
      return "Digite um e-mail válido.";
    }

    return null;
  }

  String? _validatePassword(String? text) {
    if (text!.isEmpty) {
      return "Digite a senha!!!";
    }
    return null;
  }
}
