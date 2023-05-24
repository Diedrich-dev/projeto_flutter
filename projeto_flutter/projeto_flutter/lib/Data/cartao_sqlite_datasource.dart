import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:app_gestao/Data/perfil_Entity.dart';
import 'package:app_gestao/Data/cartao_entity.dart';
import 'conexao.dart';
import 'cartao_entity.dart';
import 'package:app_gestao/Data/data_container.dart';

class CartaoSQLiteDataSource {
  Future create(CartaoEntity cartao) async {
    try {
      final Database db = await Conexao.getConexaoDB();
      cartao.cartaoID = await db.rawInsert('''insert into $CARTAO_TABLE_NAME(
        $CARTAO_COLUMN_DESCRICAO,
        $CARTAO_COLUMN_NUMERO,
        $CARTAO_COLUMN_VALIDADE,
        $CARTAO_COLUMN_CVV,
        $CARTAO_COLUMN_SENHA)
        values("${cartao.descricao}", ${cartao.numero}, "${cartao.validade}", ${cartao.cvv}, "${cartao.senha}");''');
      queryAllRows();
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await Conexao.getConexaoDB();
    return await db.query(CARTAO_TABLE_NAME);
  }

  Future<List<CartaoEntity>> getAllCartao() async {
    Database db = await Conexao.getConexaoDB();
    List<Map> dnResult = await db.rawQuery('SELECT * FROM $CARTAO_TABLE_NAME');

    List<CartaoEntity> cartoes = [];
    for (var row in dnResult) {
      // ignore: avoid_print
      print(row);
      CartaoEntity cartao = CartaoEntity();
      cartao.cartaoID = row['cartaoID'];
      cartao.descricao = row['descricao'];
      cartao.numero = int.parse(row['numero']);
      cartao.validade = DateTime.parse(row['validade']);
      cartao.senha = row['senha'];
      cartao.cvv = row['cvv'];
      cartoes.add(cartao);
    }
    return cartoes;
  }

  Future<void> atualizarCartao(CartaoEntity cartao) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'update $CARTAO_TABLE_NAME set $CARTAO_COLUMN_DESCRICAO = ?, $CARTAO_COLUMN_NUMERO = ?, $CARTAO_COLUMN_VALIDADE = ?, $CARTAO_COLUMN_CVV = ?, $CARTAO_COLUMN_SENHA = ? where id = ?',
          [
            cartao.descricao,
            cartao.numero,
            cartao.validade,
            cartao.cvv,
            cartao.senha
          ]);
    });
  }

  Future<void> deletarCartoes() async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawDelete('delete from $CARTAO_TABLE_NAME');
    });
  }

  Future<void> deletarCartao(CartaoEntity cartao) async {
    Database db = await Conexao.getConexaoDB();
    await db.transaction((txn) async {
      await txn.rawUpdate(
          'DELETE FROM $CARTAO_TABLE_NAME WHERE id = ?', [cartao.cartaoID]);
    });
  }

  Future<List<CartaoEntity>> pesquisarCARTAO(String filtro) async {
    List<CartaoEntity> cartoes = [];
    Database db = await Conexao.getConexaoDB();
    List<Map> dbResult = await db.rawQuery(
        'SELECT * FROM $CARTAO_TABLE_NAME WHERE $CARTAO_COLUMN_DESCRICAO LIKE ?',
        ['%$filtro%']);
    for (var row in dbResult) {
      CartaoEntity cartao = CartaoEntity();
      cartao.cartaoID = row['cartaoID'];
      cartao.descricao = row['descricao'];
      cartao.numero = row['numero'];
      cartao.validade = row['validade'];
      cartao.cvv = row['cvv'];
      cartao.senha = row['senha'];
      cartoes.add(cartao);
    }
    return cartoes;
  }
}
