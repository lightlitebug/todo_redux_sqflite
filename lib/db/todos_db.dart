import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/constants.dart';
import '../exceptions/custom_db_exception.dart';

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

  Future<List<Map<String, dynamic>>> getTodos() async {
    try {
      final db = await instance.database;

      List<Map<String, dynamic>> mapTodos = await db.query(
        TodoTable.tableName,
        columns: TodoTable.fields,
        orderBy: '${TodoTable.columnUpdatedAt} DESC',
      );

      return mapTodos;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getTodo(int id) async {
    try {
      final db = await instance.database;

      List<Map<String, dynamic>> mapTodos = await db.query(
        TodoTable.tableName,
        columns: TodoTable.fields,
        where: '${TodoTable.columnId} = ?',
        whereArgs: [id],
      );

      if (mapTodos.isNotEmpty) {
        return mapTodos.first;
      } else {
        throw CustomDBException('Todo with $id not found');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<int> addTodo(Map<String, dynamic> mapTodo) async {
    try {
      final db = await instance.database;
      final int id = await db.insert(
        TodoTable.tableName,
        mapTodo,
      );
      return id;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> toggleTodo(Map<String, dynamic> mapTodo) async {
    try {
      final db = await instance.database;
      final int id = mapTodo[TodoTable.columnId];

      final int result = await db.update(
        TodoTable.tableName,
        mapTodo,
        where: '${TodoTable.columnId} = ?',
        whereArgs: [id],
      );

      if (result == 1) {
        return result;
      } else {
        throw CustomDBException('Fail to toggle todo with $id');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<int> editTodo(Map<String, dynamic> mapTodo) async {
    try {
      final db = await instance.database;
      final int id = mapTodo[TodoTable.columnId];

      final int result = await db.update(
        TodoTable.tableName,
        mapTodo,
        where: '${TodoTable.columnId} = ?',
        whereArgs: [id],
      );

      if (result == 1) {
        return result;
      } else {
        throw CustomDBException('Fail to edit todo with $id');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<int> deleteTodo(int id) async {
    try {
      final db = await instance.database;

      final int result = await db.delete(
        TodoTable.tableName,
        where: '${TodoTable.columnId} = ?',
        whereArgs: [id],
      );

      if (result == 1) {
        return result;
      } else {
        throw CustomDBException('Fail to delete todo with $id');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> close() async {
    try {
      final db = await instance.database;
      await db.close();
    } catch (e) {
      rethrow;
    }
  }
}
