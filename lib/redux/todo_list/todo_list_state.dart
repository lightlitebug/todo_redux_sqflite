import 'package:equatable/equatable.dart';

import '../../models/todo_model.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;
  const TodoListState({
    required this.todos,
  });

  factory TodoListState.initial() {
    return TodoListState(
      todos: <Todo>[
        Todo(id: '1', todoDesc: 'Clean the room'),
        Todo(id: '2', todoDesc: 'Wash the dish'),
        Todo(id: '3', todoDesc: 'Do homework'),
      ],
    );
  }

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodoListState(todos: $todos)';

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }
}
