// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_gestao/cadSenha.dart';
import 'package:app_gestao/Data/senha_entity.dart';
import 'package:app_gestao/Data/senha_sqlite_datasource.dart';

class ListarSenhas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lista de senhas",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController textEditingController;

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Senhas cadastradas"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                SenhaSQLiteDataSource().deletarSenhas();
                setState(() {});
              },
              child: Text(
                "Excluir todos",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: FutureBuilder<List<SenhaEntity>>(
          future: SenhaSQLiteDataSource().getAllSenha(),
          builder: (BuildContext context,
              AsyncSnapshot<List<SenhaEntity>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  SenhaEntity item = snapshot.data![index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(color: Colors.blue),
                    onDismissed: (direction) {
                      SenhaSQLiteDataSource().deletarSenha(item);
                    },
                    child: ListTile(
                      title: Text(item.descricao!),
                      subtitle: Text(item.login!),
                      leading:
                          CircleAvatar(child: Text(item.senhaID.toString())),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(item.login!),
                                content: Text(item.senha!),
                              );
                            });
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => cadsenha()));
        },
      ),
    );
  }
}
