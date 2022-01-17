import 'package:flutter/material.dart';
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText(
                    "Celular",
                    controller: _tPhone,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText("E-mail", controller: _tEmail),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText("Senha", controller: _tPassword),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText("Confirmar senha", controller: _tConfirmPassword),
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
                  AppText("Endereço", controller: _tStreet),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText("Número", controller: _tNumber),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText("Cidade", controller: _tCity),
                  const SizedBox(
                    height: 10,
                  ),
                  AppText("Estado", controller: _tState),
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
                        AppText("Valor da diária (R\$)",
                            controller: _tDailyRate),
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
              onPressed: _onClickLogin,
            ),
          ],
        ),
      ),
    ));
  }

  void _onClickLogin() async {
    bool formOk = _formKey.currentState!.validate();

    if (!formOk)
      return;
    
  }
}
