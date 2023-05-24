import 'package:flutter/material.dart';
import 'package:app_gestao/recuperarsenha.dart';
import 'Data/perfil_sqlite_datasource.dart';
import 'cadusuario.dart';
import 'menuPrincipal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: Colors.green,
        ),
        body: Login(),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  String email = '';
  String pass = '';
  bool ocultarSenha = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Gestor de Senhas',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 200,
              child: Image.network(
                  "https://cdn.pixabay.com/photo/2017/09/26/21/54/logo-2790253_960_720.png"),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'e-mail',
                ),
                onChanged: (text) {
                  email = text;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: ocultarSenha,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                        ocultarSenha ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        ocultarSenha = !ocultarSenha;
                      });
                    },
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                ),
                onChanged: (text) {
                  pass = text;
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => recuperarSenha()));
              },
              child: const Text(
                'Esqueci a senha',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async {
                      if (await PerfilSQLiteDataSource()
                          .getPerfilLogin(email, pass)) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return menuprincipal(
                            email: email,
                          );
                        }));
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Login Incorreto!"),
                                content: Text("Verifique o usuário e senha."),
                              );
                            });
                      }
                    })),
            // ignore: sort_child_properties_last
            Row(children: <Widget>[
              const Text('Não possui conta?'),
              TextButton(
                  child: const Text(
                    'Cadastre aqui',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => cadusuario()),
                    );
                  })
            ], mainAxisAlignment: MainAxisAlignment.center),
          ],
        ));
  }
}
