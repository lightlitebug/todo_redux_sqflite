import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';
import '../../models/todo_model.dart';

enum TodoListStatus {
  initial,
  loading,
  success,
  failure,
}

class TodoListState extends Equatable {
  final TodoListStatus status;
  final List<Todo> todos;
  final CustomError error;
  const TodoListState({
    required this.status,
    required this.todos,
    required this.error,
  });

  factory TodoListState.initial() {
    return const TodoListState(
      status: TodoListStatus.initial,
      todos: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, todos, error];

  @override
  String toString() =>
      'TodoListState(status: $status, todos: $todos, error: $error)';

  TodoListState copyWith({
    TodoListStatus? status,
    List<Todo>? todos,
    CustomError? error,
  }) {
    return TodoListState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      error: error ?? this.error,
    );
  }
}
