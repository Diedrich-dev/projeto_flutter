import 'package:flutter/material.dart';

import 'Data/cartao_entity.dart';
import 'Data/cartao_sqlite_datasource.dart';
import 'cadCartao.dart';

class ListarCastoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lista de cartoes",
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
        title: Text("Lista de Cartões"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                CartaoSQLiteDataSource().deletarCartoes();
                setState(() {});
              },
              child: Text(
                "Excluir todos",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: FutureBuilder<List<CartaoEntity>>(
          future: CartaoSQLiteDataSource().getAllCartao(),
          builder: (BuildContext context,
              AsyncSnapshot<List<CartaoEntity>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  CartaoEntity item = snapshot.data![index];
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(color: Colors.blue),
                    onDismissed: (direction) {
                      CartaoSQLiteDataSource().deletarCartao(item);
                    },
                    child: ListTile(
                      title: Text(item.descricao!),
                      subtitle: Text(item.numero!.toString()),
                      leading:
                          CircleAvatar(child: Text(item.cartaoID.toString())),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(item.descricao!),
                                content: Text("Número: " +
                                    item.numero!.toString() +
                                    "\n" +
                                    "Senha: " +
                                    item.senha! +
                                    "\n" +
                                    "Validade: " +
                                    item.validade!.toString() +
                                    "\n" +
                                    "CVV: " +
                                    item.cvv.toString()),
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
              .push(MaterialPageRoute(builder: (context) => cadcartao()));
        },
      ),
    );
  }
}
