import 'package:flutter/material.dart';

alert(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: false, //não fechar o dialog clicando por fora
      builder: (context) {
        //Widget para evitar que o dialog seja fechado pelo botão de voltar do android
        return WillPopScope(
          //função que será chamada quando o botão do android de voltar for clicado
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text("Aplicativo LimpaMais"),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok")),
            ],
          ),
        );
      });
}
