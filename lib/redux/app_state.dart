import 'package:equatable/equatable.dart';

import 'todo_filter/todo_filter_state.dart';
import 'todo_list/todo_list_state.dart';
import 'todo_search/todo_search_state.dart';

class AppState extends Equatable {
  final TodoListState todoListState;
  final TodoSearchState todoSearchState;
  final TodoFilterState todoFilterState;
  const AppState({
    required this.todoListState,
    required this.todoSearchState,
    required this.todoFilterState,
  });

  factory AppState.initial() {
    return AppState(
      todoListState: TodoListState.initial(),
      todoSearchState: TodoSearchState.initial(),
      todoFilterState: TodoFilterState.initial(),
    );
  }

  @override
  List<Object> get props => [todoListState, todoSearchState, todoFilterState];

  @override
  String toString() =>
      'AppState(todoListState: $todoListState, todoSearchState: $todoSearchState, todoFilterState: $todoFilterState)';

  AppState copyWith({
    TodoListState? todoListState,
    TodoSearchState? todoSearchState,
    TodoFilterState? todoFilterState,
  }) {
    return AppState(
      todoListState: todoListState ?? this.todoListState,
      todoSearchState: todoSearchState ?? this.todoSearchState,
      todoFilterState: todoFilterState ?? this.todoFilterState,
    );
  }
}
