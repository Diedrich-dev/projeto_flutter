import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'perfil_Entity.dart';
import 'cartao_entity.dart';
import 'conexao.dart';
import 'senha_entity.dart';
import 'data_container.dart';

class SenhaSQLiteDataSource {
  Future create(SenhaEntity senha) async {
    try {
      final Database db = await Conexao.getConexaoDB();
      senha.senhaID = await db.rawInsert('''insert into $SENHA_TABLE_NAME(
        $SENHA_COLUMN_DESCRICAO,
        $SENHA_COLUMN_EMAIL,
        $SENHA_COLUMN_LOGIN,
        $SENHA_COLUMN_SENHA)
        values(
          '${senha.descricao}', '${senha.email}', '${senha.login}', '${senha.senha}'
      );''');
      queryAllRows();
      return true;
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await Conexao.getConexaoDB();
    return await db.query(SENHA_TABLE_NAME);
  }

  Future<List<SenhaEntity>> getAllSenha() async {
    Database db = await Conexao.getConexaoDB();
    List<Map> dnResult = await db.rawQuery('SELECT * FROM $SENHA_TABLE_NAME');

    List<SenhaEntity> senhas = [];
    for (var row in dnResult) {
      SenhaEntity senha = SenhaEntity();
      senha.senhaID = row['senhaID'];
      senha.descricao = row['descricao'];
      senha.login = row['login'];
      senha.senha = row['senha'];
      senhas.add(senha);
    }
    print(senhas);
    return senhas;
  }

  Future<void> atualizarSenha(SenhaEntity senha) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'update $SENHA_TABLE_NAME set $SENHA_COLUMN_DESCRICAO = ?, $SENHA_COLUMN_LOGIN = ?, $SENHA_COLUMN_SENHA = ? where id = ?',
          [senha.descricao, senha.login, senha.senha]);
    });
  }

  Future<void> deletarSenha(SenhaEntity senha) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'DELETE FROM $SENHA_TABLE_NAME WHERE id = ?', [senha.senhaID]);
    });
  }

  Future<void> deletarSenhas() async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawDelete('delete from $SENHA_TABLE_NAME');
    });
  }

  Future<List<SenhaEntity>> pesquisarSenha(String filtro) async {
    List<SenhaEntity> senhas = [];
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $SENHA_TABLE_NAME WHERE $SENHA_COLUMN_DESCRICAO LIKE ?',
        ['%$filtro%']);
    for (var row in dbResult) {
      SenhaEntity senha = SenhaEntity();
      senha.senhaID = row['senhaID'];
      senha.descricao = row['descricao'];
      senha.login = row['login'];
      senha.senha = row['senha'];
      senhas.add(senha);
    }
    return senhas;
  }

  Future<bool> getSenhaEmail(String filtro) async {
    final db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * from $SENHA_TABLE_NAME where $SENHA_COLUMN_LOGIN = ?',
        ['$filtro']);

    if (dbResult.isEmpty)
      return false;
    else
      return true;
  }
}
