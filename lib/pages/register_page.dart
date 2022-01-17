import 'package:flutter/material.dart';
import 'package:limpamais_application/widgets/app_button.dart';
import 'package:limpamais_application/widgets/app_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(
                  "Celular",
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(
                  "E-mail",
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(
                  "Senha",
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(
                  "Confirmar senha",
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
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(
                  "Número",
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(
                  "Cidade",
                ),
                const SizedBox(
                  height: 10,
                ),
                AppText(
                  "Estado",
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          this._userType == "diarist" ? Container(
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Dados da diarista:",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    )),
                const SizedBox(
                  height: 5,
                ),
                AppText(
                  "Valor da diária (R\$)",
                ),
                const SizedBox(
                  height: 5,
                ),
                AppText(
                  "Observação",
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ) : Container(),
          AppButton(
            'Cadastrar',
            onPressed: () => print('cadastrou'),
          ),
        ],
      ),
    ));
  }
}
