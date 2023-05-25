import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'Data/senha_sqlite_datasource.dart';

class recuperarSenha extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _recuperarSenha();
  }
}

class _recuperarSenha extends State<recuperarSenha> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Recuperar sua senha'),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black38,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 60, left: 40, right: 40),
          child: ListView(
            children: [sizedBox(), textoMaior(), textoMenor(), fieldEmail()],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () async {
            if (await SenhaSQLiteDataSource()
                .getSenhaEmail(_emailController.text))
              sendEmail(_emailController.text);
          },
          child: Icon(Icons.password),
        ),
      ),
    );
  }

  Widget textoMaior() {
    return Text(
      'Esqueceu sua senha',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }

  Widget textoMenor() {
    return Text(
      'Informe seu e-mail associado a sua conta para recuperar sua senha',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    );
  }

  Widget fieldEmail() {
    return TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: 'E-mail'));
  }

  Widget sizedBox() {
    return SizedBox(
      width: 200,
      height: 200,
      // child: Image.network(
      //     "https://cdn.pixabay.com/photo/2019/10/06/11/40/lock-4529981_960_720.png"),
    );
  }

  Future<void> sendEmail(String emailAddress) async {
    final Email email = Email(
      body: 'Sua senha',
      subject: 'SuaSenha',
      recipients: [emailAddress],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }
}
