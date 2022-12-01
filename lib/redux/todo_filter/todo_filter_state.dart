import 'package:equatable/equatable.dart';

import '../../models/todo_model.dart';

class TodoFilterState extends Equatable {
  final TodoFilter todoFilter;
  const TodoFilterState({
    required this.todoFilter,
  });

  factory TodoFilterState.initial() {
    return const TodoFilterState(todoFilter: TodoFilter.all);
  }

  @override
  List<Object> get props => [todoFilter];

  @override
  String toString() => 'TodoFilterState(todoFilter: $todoFilter)';

  TodoFilterState copyWith({
    TodoFilter? todoFilter,
  }) {
    return TodoFilterState(
      todoFilter: todoFilter ?? this.todoFilter,
    );
  }
}
