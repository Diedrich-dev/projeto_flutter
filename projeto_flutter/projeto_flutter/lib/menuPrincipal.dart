// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_gestao/cadSenha.dart';
import 'package:app_gestao/cadCartao.dart';
import 'package:app_gestao/perfilUsuario.dart';

import 'cadUsuario.dart';
import 'geradorSenha.dart';
import 'listarCartoes.dart';
import 'listarSenhas.dart';

class menuprincipal extends StatefulWidget {
  final String email;
  const menuprincipal({Key? key, required this.email}) : super(key: key);

  @override
  _menuprincipalstate createState() {
    return _menuprincipalstate();
  }
}

class _menuprincipalstate extends State<menuprincipal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text("Sou eu"),
                accountEmail: Text("SouEu@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  radius: 30.0,
                  // backgroundImage: NetworkImage(
                  //     'https://www.pngmart.com/files/21/Account-Avatar-Profile-PNG-Photos.png'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Favoritos"),
                  subtitle: Text("Meus favoritos..."),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    debugPrint('Toquei no drawer');
                  }),
              ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text("Perfil"),
                  subtitle: Text("perfil do usuario"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return perfilUsuario();
                    }));
                  }),
              ListTile(
                  leading: Icon(Icons.person_add_alt_1),
                  title: Text("Cadastro de usuário"),
                  subtitle: Text("cadastrar usuário"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return cadusuario();
                    }));
                  }),
              ListTile(
                  leading: Icon(Icons.lock_outline),
                  title: Text("Cadastro de senha"),
                  subtitle: Text("cadastrar senha"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return cadsenha();
                    }));
                  }),
              ListTile(
                  leading: Icon(Icons.add_card_outlined),
                  title: Text("Cadastro de cartão"),
                  subtitle: Text("cadastrar cartão"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return cadcartao();
                    }));
                  }),
              ListTile(
                  leading: Icon(Icons.password_sharp),
                  title: Text("Gerador de senha"),
                  subtitle: Text("gerar senha"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return GerarSenha();
                    }));
                  }),
              ListTile(
                  leading: Icon(Icons.list_alt_outlined),
                  title: Text("listar senhas"),
                  subtitle: Text("sua senhas geradas e salvas"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ListarSenhas();
                    }));
                  }),
              ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text("listar cartoes"),
                  subtitle: Text("seus cartões salvos"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ListarCastoes();
                    }));
                  }),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('App de Senhas e Cartões'),
        ),
        body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
            ),
            child: Text('Voltar'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Minha conta"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Senhas"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Cartões"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Favoritos"),
        ]),
      ),
    );
  }
}
