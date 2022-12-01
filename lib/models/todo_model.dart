import 'package:equatable/equatable.dart';

import '../constants/constants.dart';

class Todo extends Equatable {
  final int? id;
  final String todoDesc;
  final bool completed;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Todo({
    this.id,
    required this.todoDesc,
    this.completed = false,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      todoDesc,
      completed,
      createdAt,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'Todo(id: $id, todoDesc: $todoDesc, completed: $completed, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  Todo copyWith({
    int? id,
    String? todoDesc,
    bool? completed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      todoDesc: todoDesc ?? this.todoDesc,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json[TodoTable.columnId] as int?,
      todoDesc: json[TodoTable.columnTodoDesc] as String,
      completed: json[TodoTable.columnCompleted] == 1,
      createdAt: DateTime.parse(json[TodoTable.columnCreatedAt] as String),
      updatedAt: DateTime.parse(json[TodoTable.columnUpdatedAt] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TodoTable.columnId: id,
      TodoTable.columnTodoDesc: todoDesc,
      TodoTable.columnCompleted: completed ? 1 : 0,
      TodoTable.columnCreatedAt: createdAt.toIso8601String(),
      TodoTable.columnUpdatedAt: updatedAt.toIso8601String(),
    };
  }
}

enum TodoFilter {
  all,
  active,
  completed,
}
