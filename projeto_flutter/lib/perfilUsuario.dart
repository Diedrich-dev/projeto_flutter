// ignore: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class perfilUsuario extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Perfil do usuário',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final _picker = ImagePicker();

  Future<void> _openImagePicker() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.front,
      // imageMaxWidth: 1000,
      // imageMaxHeight: 1000,
      // cameraDevice: CameraDevice.front,
      // mimeTypes: ['image/jpeg', 'image/png', 'image/jpg'],
    );
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(children: [
            Center(
              child: ElevatedButton(
                onPressed: _openImagePicker,
                child: const Text('Selecione uma imagem'),
                style: ElevatedButton.styleFrom(primary: Colors.blue),
              ),
            ),
            const SizedBox(height: 35),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 300,
              color: Colors.grey[300],
              child: _image != null
                  ? Image.file(_image!, fit: BoxFit.cover)
                  : const Text('Por favor selecione a imagem'),
            ),
            const SizedBox(height: 20),
            fieldName(),
            const SizedBox(height: 20),
            fieldEmail(),
            const SizedBox(height: 20),
            fieldSenha(),
          ]),
        ),
      ),
    );
  }

  Widget fieldEmail() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'E-mail',
        ),
      ),
    );
  }

  Widget fieldSenha() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      // ignore: prefer_const_constructors
      child: TextField(
        obscureText: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Senha',
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
}
