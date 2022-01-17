import 'package:flutter/material.dart';
import 'package:limpamais_application/api/api_response.dart';
import 'package:limpamais_application/api/diarist/diarist_api.dart';
import 'package:limpamais_application/api/user/user_api.dart';
import 'package:limpamais_application/models/user.dart';
import 'package:limpamais_application/pages/login_page.dart';
import 'package:limpamais_application/utils/alert.dart';
import 'package:limpamais_application/utils/nav.dart';
import 'package:limpamais_application/widgets/app_button.dart';
import 'package:limpamais_application/widgets/app_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _tName = TextEditingController();
  final _tPhone = TextEditingController();
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();
  final _tConfirmPassword = TextEditingController();
  final _tStreet = TextEditingController();
  final _tNumber = TextEditingController();
  final _tCity = TextEditingController();
  final _tState = TextEditingController();
  final _tDailyRate = TextEditingController();
  final _tNote = TextEditingController();

  String _userType = "user";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cadastro"),
      ),
      body: Stack(
        children: [
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
          _body(context)
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tipo de usuário:",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                )),
            Row(
              children: [
                Radio(
                    value: "user",
                    groupValue: _userType,
                    onChanged: (value) {
                      setState(() {
                        _userType = value as String;
                      });
                    }),
                const Text(
                  "Usuário",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                const SizedBox(
                  width: 40,
                ),
                Radio(
                    value: "diarist",
                    groupValue: _userType,
                    onChanged: (value) {
                      setState(() {
                        _userType = value as String;
                      });
                    }),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Diarista",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Dados da conta:",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  AppText(
                    "Nome completo",
                    controller: _tName,
                    validator: _validateField,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText(
                    "Celular",
                    controller: _tPhone,
                    validator: _validateField,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText("E-mail",
                      controller: _tEmail, validator: _validateEmail),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText(
                    "Senha",
                    controller: _tPassword,
                    validator: _validateField,
                    password: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText(
                    "Confirmar senha",
                    controller: _tConfirmPassword,
                    validator: _validateConfirmPassword,
                    password: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Endereço:",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  AppText(
                    "Endereço",
                    controller: _tStreet,
                    validator: _validateField,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText(
                    "Número",
                    controller: _tNumber,
                    validator: _validateField,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText(
                    "Cidade",
                    controller: _tCity,
                    validator: _validateField,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText(
                    "Estado",
                    controller: _tState,
                    validator: _validateField,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            this._userType == "diarist"
                ? Container(
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Dados da diarista:",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        AppText(
                          "Valor da diária (R\$)",
                          controller: _tDailyRate,
                          validator: _validateField,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        AppText("Observação", controller: _tNote),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                : Container(),
            AppButton(
              'Cadastrar',
              onPressed: _onClickRegister,
            ),
          ],
        ),
      ),
    ));
  }

  void _onClickRegister() async {
    bool formOk = _formKey.currentState!.validate();

    if (!formOk) {
      return;
    }

    String name = _tName.text;
    String email = _tEmail.text;
    String phone = _tPhone.text;
    String password = _tPassword.text;
    String street = _tStreet.text;
    String number = _tNumber.text;
    String city = _tCity.text;
    String state = _tState.text;
    String dailyRate = _tDailyRate.text;
    String note = _tNote.text;

    if (_userType == "user") {
      String response = await UserApi.createUser(
          name, email, password, phone, street, number, city, state);

      push(context, const LoginPage(), replace: true);
      alert(context, response);
    } else {

      String response = await DiaristsApi.createUser(
          name, email, password, phone, street, number, city, state, dailyRate, note);
      
      push(context, const LoginPage(), replace: true);
      alert(context, response);
    }
  }

  String? _validateEmail(String? text) {
    if (text!.isEmpty) {
      return "Campo obrigatório.";
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(text)) {
      return "Digite um e-mail válido.";
    }

    return null;
  }

  String? _validateField(String? text) {
    if (text!.isEmpty) {
      return "Campo obrigatório.";
    }
  }

  String? _validateConfirmPassword(String? text) {
    if (text != _tPassword.text) {
      return "O campo precisa ter a mesma senha do campo acima.";
    }
  }
}
