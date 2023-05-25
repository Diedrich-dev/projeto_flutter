// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Data/cartao_entity.dart';
import 'Data/cartao_sqlite_datasource.dart';
import 'listarCartoes.dart';

class cadcartao extends StatefulWidget {
  @override
  cadcartaoState createState() {
    return cadcartaoState();
  }
}

class cadcartaoState extends State<cadcartao> {
  TextEditingController descricaoController = TextEditingController();
  TextEditingController numeroCartaoController = TextEditingController();
  TextEditingController validadeController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  bool ocultarSenha = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de cartões'),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black38,
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            fieldDescricao(),
            SizedBox(
              height: 20,
            ),
            CartaoFrente(context),
            SizedBox(
              height: 20,
            ),
            CartaoAtras(context),
            SizedBox(
              height: 05,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () {
            CartaoEntity cartao = new CartaoEntity();
            cartao.descricao = descricaoController.text;
            cartao.numero = int.parse(numeroCartaoController.text);
            cartao.validade = DateTime.parse(validadeController.text);
            cartao.cvv = cvvController.text;
            cartao.senha = senhaController.text;
            CartaoSQLiteDataSource().create(cartao);
            Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ListarCastoes()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget fieldNumero() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: numeroCartaoController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Número',
        ),
      ),
    );
  }

  Widget fieldValidade() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: validadeController,
        keyboardType: TextInputType.datetime,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Validade',
        ),
      ),
    );
  }

  Widget fieldCvv() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: cvvController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'CVV',
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
          labelText: 'Descrição',
        ),
      ),
    );
  }

  Widget fieldSenha() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextField(
        controller: senhaController,
        obscureText: ocultarSenha,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: "Informe a sua senha",
          labelText: "Senha",
          helperText: "Digite uma senha para sua segurança",
          helperStyle: TextStyle(color: Color.fromARGB(255, 31, 58, 32)),
          suffixIcon: IconButton(
            icon: Icon(ocultarSenha ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(
                () {
                  ocultarSenha = !ocultarSenha;
                },
              );
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

  Widget textNome() {
    return Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Seu Nome',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )));
  }

  Widget CartaoFrente(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [cartaoFront(context)],
      ),
    );
  }

  Widget cartaoFront(context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.blue),
      child: Column(
        children: [fieldNumero(), fieldValidade(), fieldSenha(), textNome()],
      ),
    );
  }

  Widget CartaoAtras(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [cartaoBack(context)],
      ),
    );
  }

  Widget cartaoBack(context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.blue),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(height: 40, color: Colors.black),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 40,
            color: Color.fromARGB(255, 229, 96, 0),
          ),
          fieldCvv(),
        ],
      ),
    );
  }
}
