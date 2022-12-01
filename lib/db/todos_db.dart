import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/constants.dart';

class TodosDB {
  TodosDB._();
  static final TodosDB _instance = TodosDB._();
  static TodosDB get instance => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    try {
      final String dbLoc = await getDatabasesPath();
      final String dbPath = join(dbLoc, dbName);

      _database = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(TodoTable.createTodoTable);
        },
      );

      return _database!;
    } catch (e) {
      rethrow;
    }
  }
}
