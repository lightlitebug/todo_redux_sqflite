const String dbName = 'todos.db';

class TodoTable {
  // define table name
  static const String tableName = 'todos';
  // define indivisual fields
  static const String columnId = '_id';
  static const String columnTodoDesc = 'todoDesc';
  static const String columnCompleted = 'completed';
  static const String columnCreatedAt = 'createdAt';
  static const String columnUpdatedAt = 'updatedAt';
  // define all fields
  static const List<String> fields = [
    columnId,
    columnTodoDesc,
    columnCompleted,
    columnCreatedAt,
    columnUpdatedAt,
  ];
}
