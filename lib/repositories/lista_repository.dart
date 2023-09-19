import 'package:listadecompras/models/lista_models.dart';
import 'package:listadecompras/classes/db_provider.dart';

class ListaRepositorio {
  //Este código faz os inserts no banco de dados!!!
  static Future<void> add(ListaModel listaModel) async {
    DBProvider dbProvider = DBProvider();
    var db = await dbProvider.db;
    await db.insert(LISTACOMPRAS_TABLE, listaModel.toJson());
  }

  //Este código faz o update no banco de dados!!!
  static Future<void> update(ListaModel listaModel) async {
    DBProvider dbProvider = DBProvider();
    var db = await dbProvider.db;
    await db.update(LISTACOMPRAS_TABLE, listaModel.toJson(),
      where: "${LISTACOMPRAS_FIELD_ID} = ?", whereArgs:  [listaModel.id]);
  }

  //Este código faz o delete no banco de dados!!!
  static Future<void> delete(ListaModel listaModel) async{
    DBProvider dbProvider = DBProvider();
    var db = await dbProvider.db;
    await db.delete(LISTACOMPRAS_TABLE,
      where: "${LISTACOMPRAS_FIELD_ID} = ?", whereArgs: [listaModel.id]);
  }

  //Pega todos os itens do Banco de dados!!!
  static Future<List<ListaModel>> getAll() async {
    DBProvider dbProvider = DBProvider();
    var db = await dbProvider.db;
    var rows = await db.query(LISTACOMPRAS_TABLE);
    List<ListaModel> lista = [];
    rows.forEach((element) => lista.add(ListaModel.fromJson(element)));
    return lista;
  }
  //Pega um item do Banco de dados!!!
  static Future<ListaModel?> get(int id) async {
    DBProvider dbProvider = DBProvider();
    var db = await dbProvider.db;
    var rows = await db.query(LISTACOMPRAS_TABLE, where: "${LISTACOMPRAS_FIELD_ID} = ?", whereArgs: [id]);
    if (rows.isEmpty)
      return null;
    return ListaModel.fromJson(rows.first);
  }

}