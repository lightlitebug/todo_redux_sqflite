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

class AddTodoAction {
  final String todoDesc;
  AddTodoAction({
    required this.todoDesc,
  });

  @override
  String toString() => 'AddTodoAction(todoDesc: $todoDesc)';
}

class EditTodoAction {
  final String id;
  final String todoDesc;
  EditTodoAction({
    required this.id,
    required this.todoDesc,
  });

  @override
  String toString() => 'EditTodoAction(id: $id, todoDesc: $todoDesc)';
}

class ToggleTodoAction {
  final String id;
  ToggleTodoAction({
    required this.id,
  });

  @override
  String toString() => 'ToggleTodoAction(id: $id)';
}

class DeleteTodoAction {
  final String id;
  DeleteTodoAction({
    required this.id,
  });

  @override
  String toString() => 'DeleteTodoAction(id: $id)';
}
