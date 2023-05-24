// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_element, camel_case_types

import 'package:app_gestao/Data/perfil_sqlite_datasource.dart';
import 'package:flutter/material.dart';

import 'Data/perfil_Entity.dart';

class cadusuario extends StatefulWidget {
  @override
  _cadusuarioState createState() {
    return _cadusuarioState();
  }
}

class _cadusuarioState extends State<cadusuario> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarsenhaController = TextEditingController();
  bool ocultarSenha = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de usuário'),
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black38,
            onPressed: () => Navigator.pop(context, false),
          ),
          actions: [IconButton(onPressed: null, icon: Icon(Icons.save))],
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
              child: Column(
            children: [
              fieldName(),
              SizedBox(
                height: 10,
              ),
              fieldEmail(),
              SizedBox(
                height: 10,
              ),
              fieldSenha(),
              SizedBox(
                height: 10,
              ),
              fieldConfirmarSenha(),
              SizedBox(
                height: 10,
              ),
              buttonCadastrar(context),
            ],
          )),
        ),
      ),
    );
  }

  Widget fieldName() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Nome',
        ),
      ),
    );
  }

  Widget fieldEmail() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: emailController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'E-mail',
        ),
      ),
    );
  }

  Widget fieldSenha() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: senhaController,
        obscureText: ocultarSenha,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: "Informe a sua senha",
          labelText: 'Senha',
          helperText: "Digite uma senha para a sua segurança",
          helperStyle: TextStyle(color: Colors.green),
          suffixIcon: IconButton(
            icon: Icon(ocultarSenha ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                ocultarSenha = !ocultarSenha;
              });
            },
          ),
          alignLabelWithHint: false,
          filled: true,
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget fieldConfirmarSenha() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: confirmarsenhaController,
        obscureText: ocultarSenha,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Confirmar Senha',
          helperText: "Digite novamente a senha",
          helperStyle: TextStyle(color: Colors.green),
          suffixIcon: IconButton(
            icon: Icon(ocultarSenha ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                ocultarSenha = !ocultarSenha;
              });
            },
          ),
          alignLabelWithHint: false,
          filled: true,
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget buttonCadastrar(context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ElevatedButton(
          onPressed: () {
            if (confirmarsenhaController.text == senhaController.text) {
              PerfilEntity perfil = new PerfilEntity();
              perfil.email = emailController.text;
              perfil.nome = nomeController.text;
              perfil.senha = senhaController.text;
              PerfilSQLiteDataSource().create(perfil);
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          child: const Text('Cadastrar'),
        ),
      ),
    );
  }
}
