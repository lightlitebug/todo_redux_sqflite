import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

class Todo extends Equatable {
  final String id;
  final String todoDesc;
  final bool completed;
  Todo({
    String? id,
    required this.todoDesc,
    this.completed = false,
  }) : id = id ?? uuid.v4();

  @override
  List<Object> get props => [id, todoDesc, completed];

  @override
  String toString() =>
      'Todo(id: $id, todoDesc: $todoDesc, completed: $completed)';

  Todo copyWith({
    String? id,
    String? todoDesc,
    bool? completed,
  }) {
    return Todo(
      id: id ?? this.id,
      todoDesc: todoDesc ?? this.todoDesc,
      completed: completed ?? this.completed,
    );
  }
}

enum TodoFilter {
  all,
  active,
  completed,
}
