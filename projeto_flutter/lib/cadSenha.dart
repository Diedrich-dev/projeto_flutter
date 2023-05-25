import 'package:flutter/material.dart';
import 'package:projeto_flutter/listarSenhas.dart';

import 'Data/senha_entity.dart';
import 'Data/senha_sqlite_datasource.dart';

class cadsenha extends StatefulWidget {
  @override
  _cadsenhaState createState() {
    return _cadsenhaState();
  }
}

class _cadsenhaState extends State<cadsenha> {
  TextEditingController descricaoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  bool ocultarSenha = false;

  @override
  void initState() {
    super.initState();
    ocultarSenha = true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de Senhas'),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black38,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                fieldDescricao(),
                fieldEmail(),
                fieldLogin(),
                fieldSenha(),
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () {
            SenhaEntity senha = new SenhaEntity();
            senha.descricao = descricaoController.text;
            senha.email = descricaoController.text;
            senha.login = loginController.text;
            senha.senha = senhaController.text;
            SenhaSQLiteDataSource().create(senha);
            Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ListarSenhas()));
          },
        ),
      ),
    );
  }

  Widget fieldDescricao() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: descricaoController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Informe a descrição',
        ),
      ),
    );
  }

  Widget fieldEmail() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: emailController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
        ),
      ),
    );
  }

  Widget fieldLogin() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: TextField(
          controller: loginController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Login',
          ),
        ));
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
          helperStyle: TextStyle(color: Colors.blue),
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
}
