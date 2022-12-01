import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:redux/redux.dart';

import '../models/custom_error.dart';
import '../redux/app_state.dart';
import '../redux/todo_list/todo_list_action.dart';
import '../redux/todo_list/todo_list_state.dart';
import 'filter_todo.dart';
import 'new_todo.dart';
import 'search_todo.dart';
import 'show_todos.dart';
import 'todo_header.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StoreConnector<AppState, _ViewModel>(
        distinct: true,
        onInit: (Store<AppState> store) {
          store.dispatch(getTodoListAndDispatch());
        },
        onWillChange: (_ViewModel? prev, _ViewModel current) {
          if (current.status == TodoListStatus.failure) {
            errorDialog(context, current.error);
          }
        },
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
            body: ModalProgressHUD(
              inAsyncCall: vm.status == TodoListStatus.loading,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: const [
                      TodoHeader(),
                      NewTodo(),
                      SizedBox(height: 20.0),
                      SearchTodo(),
                      SizedBox(height: 20.0),
                      FilterTodo(),
                      SizedBox(height: 10.0),
                      ShowTodos(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ViewModel extends Equatable {
  final TodoListStatus status;
  final CustomError error;
  const _ViewModel({
    required this.status,
    required this.error,
  });

  @override
  List<Object> get props => [status, error];

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      status: store.state.todoListState.status,
      error: store.state.todoListState.error,
    );
  }
}
