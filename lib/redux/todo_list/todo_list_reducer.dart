import 'package:redux/redux.dart';

import '../../models/todo_model.dart';
import 'todo_list_action.dart';
import 'todo_list_state.dart';

TodoListState addTodoReducer(
  TodoListState state,
  AddTodoAction action,
) {
  final newTodos = [...state.todos, Todo(todoDesc: action.todoDesc)];
  return state.copyWith(todos: newTodos);
}

TodoListState toggleTodoReducer(
  TodoListState state,
  ToggleTodoAction action,
) {
  final newTodos = state.todos.map((Todo todo) {
    if (todo.id == action.id) {
      final newTodo = todo.copyWith(completed: !todo.completed);
      return newTodo;
    } else {
      return todo;
    }
  }).toList();

  return state.copyWith(todos: newTodos);
}

TodoListState editTodoReducer(
  TodoListState state,
  EditTodoAction action,
) {
  final newTodos = state.todos.map((Todo todo) {
    if (todo.id == action.id) {
      final newTodo = todo.copyWith(todoDesc: action.todoDesc);
      return newTodo;
    } else {
      return todo;
    }
  }).toList();

  return state.copyWith(todos: newTodos);
}

TodoListState deleteTodoReducer(
  TodoListState state,
  DeleteTodoAction action,
) {
  final newTodos = state.todos.where((Todo todo) {
    if (todo.id == action.id) {
      return false;
    } else {
      return true;
    }
  }).toList();

  return state.copyWith(todos: newTodos);
}

Reducer<TodoListState> todoListReducer = combineReducers<TodoListState>([
  TypedReducer<TodoListState, AddTodoAction>(addTodoReducer),
  TypedReducer<TodoListState, ToggleTodoAction>(toggleTodoReducer),
  TypedReducer<TodoListState, EditTodoAction>(editTodoReducer),
  TypedReducer<TodoListState, DeleteTodoAction>(deleteTodoReducer),
]);
