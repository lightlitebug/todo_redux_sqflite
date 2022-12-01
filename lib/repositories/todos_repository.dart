import '../db/todos_db.dart';
import '../models/todo_model.dart';
import 'handle_exception.dart';

class TodosRepository {
  TodosRepository._();
  static final TodosRepository _instance = TodosRepository._();
  static TodosRepository get instance => _instance;

  Future<List<Todo>> getTodos() async {
    try {
      final List<Map<String, dynamic>> mapTodos =
          await TodosDB.instance.getTodos();

      List<Todo> todos = mapTodos.map((todo) => Todo.fromJson(todo)).toList();

      return todos;
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<Todo> getTodo(int id) async {
    try {
      final Map<String, dynamic> mapTodo = await TodosDB.instance.getTodo(id);
      final Todo todo = Todo.fromJson(mapTodo);
      return todo;
    } catch (e) {
      throw handleException(e);
    }
  }

  Future addTodo(Todo todo) async {
    try {
      final int id = await TodosDB.instance.addTodo(todo.toJson());
      return todo.copyWith(id: id);
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> toggleTodo(Todo todo) async {
    try {
      await TodosDB.instance.toggleTodo(todo.toJson());
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> editTodo(Todo todo) async {
    try {
      await TodosDB.instance.editTodo(todo.toJson());
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      await TodosDB.instance.deleteTodo(id);
    } catch (e) {
      throw handleException(e);
    }
  }

  Future<void> closeDB() async {
    try {
      await TodosDB.instance.close();
    } catch (e) {
      throw handleException(e);
    }
  }
}
