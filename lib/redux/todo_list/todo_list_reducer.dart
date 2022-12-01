import 'package:redux/redux.dart';

import 'todo_list_action.dart';
import 'todo_list_state.dart';

/////////////////////////////////////////////////////////////////
/// Get todo list related reducers
/////////////////////////////////////////////////////////////////
TodoListState getTodoListReducer(
  TodoListState state,
  GetTodoListAction action,
) {
  return state.copyWith(status: TodoListStatus.loading);
}

TodoListState getTodoListSucceededReducer(
  TodoListState state,
  GetTodoListSucceededAction action,
) {
  return state.copyWith(
    status: TodoListStatus.success,
    todos: action.todos,
  );
}

TodoListState getTodoListFailedReducer(
  TodoListState state,
  GetTodoListFailedAction action,
) {
  return state.copyWith(
    status: TodoListStatus.failure,
    error: action.error,
  );
}

/////////////////////////////////////////////////////////////////
/// Add todo related reducers
/////////////////////////////////////////////////////////////////
TodoListState addTodoReducer(
  TodoListState state,
  AddTodoAction action,
) {
  return state.copyWith(status: TodoListStatus.loading);
}

TodoListState addTodoSucceededReducer(
  TodoListState state,
  AddTodoSucceededAction action,
) {
  final newTodos = [action.todo, ...state.todos];
  return state.copyWith(
    status: TodoListStatus.success,
    todos: newTodos,
  );
}

TodoListState addTodoFailedReducer(
  TodoListState state,
  AddTodoFailedAction action,
) {
  return state.copyWith(
    status: TodoListStatus.failure,
    error: action.error,
  );
}

/////////////////////////////////////////////////////////////////
/// Toggle todo related reducers
/////////////////////////////////////////////////////////////////

TodoListState toggleTodoReducer(
  TodoListState state,
  ToggleTodoAction action,
) {
  return state.copyWith(status: TodoListStatus.loading);
}

TodoListState toggleTodoSucceededReducer(
  TodoListState state,
  ToggleTodoSucceededAction action,
) {
  final newTodos = state.todos
      .map((todo) => todo.id == action.todo.id ? action.todo : todo)
      .toList();
  newTodos.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  return state.copyWith(
    status: TodoListStatus.success,
    todos: newTodos,
  );
}

TodoListState toggleTodoFailedReducer(
  TodoListState state,
  ToggleTodoFailedAction action,
) {
  return state.copyWith(
    status: TodoListStatus.failure,
    error: action.error,
  );
}

/////////////////////////////////////////////////////////////////
/// Edit todo related reducers
/////////////////////////////////////////////////////////////////

TodoListState editTodoReducer(
  TodoListState state,
  EditTodoAction action,
) {
  return state.copyWith(status: TodoListStatus.loading);
}

TodoListState editTodoSucceededReducer(
  TodoListState state,
  EditTodoSucceededAction action,
) {
  final newTodos = state.todos
      .map((todo) => todo.id == action.todo.id ? action.todo : todo)
      .toList();
  newTodos.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  return state.copyWith(
    status: TodoListStatus.success,
    todos: newTodos,
  );
}

TodoListState editTodoFailedReducer(
  TodoListState state,
  EditTodoFailedAction action,
) {
  return state.copyWith(
    status: TodoListStatus.failure,
    error: action.error,
  );
}

/////////////////////////////////////////////////////////////////
/// Delete todo related reducers
/////////////////////////////////////////////////////////////////
TodoListState deleteTodoReducer(
  TodoListState state,
  DeleteTodoAction action,
) {
  return state.copyWith(status: TodoListStatus.loading);
}

TodoListState deleteTodoSucceededReducer(
  TodoListState state,
  DeleteTodoSucceededAction action,
) {
  final newTodos = state.todos.where((todo) => todo.id != action.id).toList();
  return state.copyWith(
    status: TodoListStatus.success,
    todos: newTodos,
  );
}

TodoListState deleteTodoFailedReducer(
  TodoListState state,
  DeleteTodoFailedAction action,
) {
  return state.copyWith(
    status: TodoListStatus.failure,
    error: action.error,
  );
}

Reducer<TodoListState> todoListReducer = combineReducers<TodoListState>([
  TypedReducer<TodoListState, GetTodoListAction>(getTodoListReducer),
  TypedReducer<TodoListState, GetTodoListSucceededAction>(
    getTodoListSucceededReducer,
  ),
  TypedReducer<TodoListState, GetTodoListFailedAction>(
    getTodoListFailedReducer,
  ),
  TypedReducer<TodoListState, AddTodoAction>(addTodoReducer),
  TypedReducer<TodoListState, AddTodoSucceededAction>(
    addTodoSucceededReducer,
  ),
  TypedReducer<TodoListState, AddTodoFailedAction>(
    addTodoFailedReducer,
  ),
  TypedReducer<TodoListState, ToggleTodoAction>(toggleTodoReducer),
  TypedReducer<TodoListState, ToggleTodoSucceededAction>(
    toggleTodoSucceededReducer,
  ),
  TypedReducer<TodoListState, ToggleTodoFailedAction>(
    toggleTodoFailedReducer,
  ),
  TypedReducer<TodoListState, EditTodoAction>(editTodoReducer),
  TypedReducer<TodoListState, EditTodoSucceededAction>(
    editTodoSucceededReducer,
  ),
  TypedReducer<TodoListState, EditTodoFailedAction>(
    editTodoFailedReducer,
  ),
  TypedReducer<TodoListState, DeleteTodoAction>(deleteTodoReducer),
  TypedReducer<TodoListState, DeleteTodoSucceededAction>(
    deleteTodoSucceededReducer,
  ),
  TypedReducer<TodoListState, DeleteTodoFailedAction>(
    deleteTodoFailedReducer,
  ),
]);
