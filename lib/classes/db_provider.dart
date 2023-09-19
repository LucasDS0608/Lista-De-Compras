import 'package:listadecompras/models/lista_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  //Implementação do Singleton armazenar a conexão com o banco de dados. Caso o database ainda não exista, criará as tabelas.
  static final DBProvider _instance =DBProvider.internal();
  factory DBProvider() => _instance;
  DBProvider.internal();

  //Busca e criação da base de dados
  Database? _db;
  Future<Database> get db async{
    if (_db != null)
      return _db!;

    _db = await _initDB();

    return _db!;
  }

  //Esse é o código que criara o banco de dados
  Future<Database> _initDB() async {
    String dirPath = await getDatabasesPath();
    String dbPath = join(dirPath, 'listacompras.db');

    print(dbPath);

    return await openDatabase(dbPath, version: 1, onCreate: (db, version) async{
      db.execute("CREATE TABLE ${LISTACOMPRAS_TABLE} ("
          "${LISTACOMPRAS_FIELD_ID} INTEGER PRIMARY KEY,"
          "${LISTACOMPRAS_FIELD_ITEM} VARCHAR(50),"
          "${LISTACOMPRAS_FIELD_COMPRADO} TINYINT"
          ")");
    });
  }
}