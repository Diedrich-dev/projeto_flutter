// ignore_for_file: prefer_const_constructors, unused_element, file_names, use_key_in_widget_constructors, non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';

bool _a_z = false;
bool _A_Z = false;
bool _zero_nove = false;
bool _arroba_hashtag_exclamacao = false;
double _currentSliderValue = 0;
String _pass = "";

class GerarSenha extends StatelessWidget {
  const GerarSenha({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Gerar Senha'),
      ),
      body: const _Body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: Icon(Icons.password),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 60, left: 40, right: 40),
      child: ListView(
        children: [
          sizedBox(),
          textoMaior(),
          textoMenor(),
          SizedBox(height: 20),
          fieldSenha(),
          SizedBox(height: 20),
          checkBoxSelecao(),
          SizedBox(height: 20),
          addRange(),
          SizedBox(height: 20),
          gerarSenhaButton()
        ],
      ),
    );
  }

  Widget sizedBox() {
    return SizedBox(
        width: 128,
        height: 128,
        child: Icon(
          Icons.lock_reset,
          size: 128,
        ));
  }

  Widget textoMaior() {
    return Text(
      'Gerador automático de senha',
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget textoMenor() {
    return Text(
      'Aqui você escolhe como deseja gerar sua senha',
      style: TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    );
  }

  Widget fieldSenha() {
    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: _pass,
        labelStyle: TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
      style: TextStyle(fontSize: 20),
    );
  }

  Widget checkBoxSelecao() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: _A_Z,
              activeColor: Colors.blue,
              onChanged: (bool? value) {
                setState(() {
                  _A_Z = value!;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Text('A-Z'),
            ),
          ],
        ),
        SizedBox(width: 3),
        Row(
          children: [
            Checkbox(
              value: _a_z,
              activeColor: Colors.blue,
              onChanged: (bool? value) {
                setState(() {
                  _a_z = value!;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Text('a-z'),
            ),
          ],
        ),
        SizedBox(width: 3),
        Row(
          children: [
            Checkbox(
              value: _zero_nove,
              activeColor: Colors.blue,
              onChanged: (bool? value) {
                setState(() {
                  _zero_nove = value!;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Text('0-9'),
            ),
          ],
        ),
        SizedBox(width: 3),
        Row(
          children: [
            Checkbox(
              value: _arroba_hashtag_exclamacao,
              activeColor: Colors.blue,
              onChanged: (bool? value) {
                setState(() {
                  _arroba_hashtag_exclamacao = value!;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Text('@#!'),
            ),
          ],
        ),
      ],
    );
  }

  Widget addRange() {
    return Slider(
      value: _currentSliderValue,
      max: 16,
      divisions: 16,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );
  }

  Widget gerarSenhaButton() {
    return ElevatedButton(
      onPressed: () {
        geradorPassWord();
      },
      child: Text(
        'Gerar Senha',
        style: TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  geradorPassWord() {
    List<String> charList = <String>[
      _A_Z ? 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' : '',
      _a_z ? 'abcdefghijklmnopqrstuvwxyz' : '',
      _zero_nove ? '0123456789' : '',
      _arroba_hashtag_exclamacao ? '!@#\$%¨&*_=+,.<>:;/?' : ''
    ];

    final String chars = charList.join('');
    String senha = "";
    Random random = Random();

    senha = String.fromCharCodes(Iterable.generate(_currentSliderValue.round(),
        (_) => chars.codeUnitAt(random.nextInt(chars.length))));
    setState(() {
      _pass = senha;
    });
  }
}
