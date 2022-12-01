import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../models/custom_error.dart';
import '../../models/todo_model.dart';
import '../../repositories/todos_repository.dart';
import '../app_state.dart';

/////////////////////////////////////////////////////////////////
/// GetTodoList related actions
/////////////////////////////////////////////////////////////////

class GetTodoListAction {
  @override
  String toString() => 'GetTodoListAction()';
}

class GetTodoListSucceededAction {
  final List<Todo> todos;
  GetTodoListSucceededAction({
    required this.todos,
  });

  @override
  String toString() => 'GetTodoListSucceededAction(todos: $todos)';
}

class GetTodoListFailedAction {
  final CustomError error;
  GetTodoListFailedAction({
    required this.error,
  });

  @override
  String toString() => 'GetTodoListFailedAction(error: $error)';
}

ThunkAction<AppState> getTodoListAndDispatch() {
  return (Store<AppState> store) async {
    store.dispatch(GetTodoListAction());

    try {
      await Future.delayed(const Duration(seconds: 1));

      final List<Todo> todos = await TodosRepository.instance.getTodos();
      store.dispatch(GetTodoListSucceededAction(todos: todos));
    } on CustomError catch (error) {
      store.dispatch(GetTodoListFailedAction(error: error));
    }
  };
}

/////////////////////////////////////////////////////////////////
/// Add todo related actions
/////////////////////////////////////////////////////////////////

class AddTodoAction {
  AddTodoAction();

  @override
  String toString() => 'AddTodoAction()';
}

class AddTodoSucceededAction {
  final Todo todo;
  AddTodoSucceededAction({
    required this.todo,
  });

  @override
  String toString() => 'AddTodoSucceededAction(todo: $todo)';
}

class AddTodoFailedAction {
  final CustomError error;
  AddTodoFailedAction({
    required this.error,
  });

  @override
  String toString() => 'AddTodoFailedAction(error: $error)';
}

ThunkAction<AppState> addTodoAndDispatch(String todoDesc) {
  return (Store<AppState> store) async {
    store.dispatch(AddTodoAction());

    try {
      final now = DateTime.now();
      final todo = Todo(
        todoDesc: todoDesc,
        createdAt: now,
        updatedAt: now,
      );

      await Future.delayed(const Duration(seconds: 1));

      final Todo newTodo = await TodosRepository.instance.addTodo(todo);
      store.dispatch(AddTodoSucceededAction(todo: newTodo));
    } on CustomError catch (error) {
      store.dispatch(AddTodoFailedAction(error: error));
    }
  };
}

/////////////////////////////////////////////////////////////////
/// Toggle todo related actions
/////////////////////////////////////////////////////////////////

class ToggleTodoAction {
  ToggleTodoAction();

  @override
  String toString() => 'ToggleTodoAction()';
}

class ToggleTodoSucceededAction {
  final Todo todo;
  ToggleTodoSucceededAction({
    required this.todo,
  });

  @override
  String toString() => 'ToggleTodoSucceededAction(todo: $todo)';
}

class ToggleTodoFailedAction {
  final CustomError error;
  ToggleTodoFailedAction({
    required this.error,
  });

  @override
  String toString() => 'ToggleTodoFailedAction(error: $error)';
}

ThunkAction<AppState> toggleTodoAndDispatch(Todo todo) {
  return (Store<AppState> store) async {
    store.dispatch(ToggleTodoAction());

    try {
      final updatedTodo = todo.copyWith(
        completed: !todo.completed,
        updatedAt: DateTime.now(),
      );

      await TodosRepository.instance.toggleTodo(updatedTodo);
      store.dispatch(ToggleTodoSucceededAction(todo: updatedTodo));
    } on CustomError catch (error) {
      store.dispatch(ToggleTodoFailedAction(error: error));
    }
  };
}

/////////////////////////////////////////////////////////////////
/// Edit todo related actions
/////////////////////////////////////////////////////////////////

class EditTodoAction {
  @override
  String toString() => 'EditTodoAction()';
}

class EditTodoSucceededAction {
  final Todo todo;
  EditTodoSucceededAction({
    required this.todo,
  });

  @override
  String toString() => 'EditTodoSucceededAction(todo: $todo)';
}

class EditTodoFailedAction {
  final CustomError error;
  EditTodoFailedAction({
    required this.error,
  });

  @override
  String toString() => 'EditTodoFailedAction(error: $error)';
}

ThunkAction<AppState> editTodoAndDispatch(Todo todo, String todoDesc) {
  return (Store<AppState> store) async {
    store.dispatch(EditTodoAction());

    try {
      final updatedTodo = todo.copyWith(
        todoDesc: todoDesc,
        updatedAt: DateTime.now(),
      );

      await Future.delayed(const Duration(seconds: 1));

      await TodosRepository.instance.editTodo(updatedTodo);

      store.dispatch(EditTodoSucceededAction(todo: updatedTodo));
    } on CustomError catch (error) {
      store.dispatch(EditTodoFailedAction(error: error));
    }
  };
}

class DeleteTodoAction {
  final String id;
  DeleteTodoAction({
    required this.id,
  });

  @override
  String toString() => 'DeleteTodoAction(id: $id)';
}
