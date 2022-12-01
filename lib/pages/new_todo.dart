import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../redux/app_state.dart';
import '../redux/todo_list/todo_list_action.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({Key? key}) : super(key: key);

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final TextEditingController newTodoController = TextEditingController();

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return TextField(
          controller: newTodoController,
          decoration: const InputDecoration(labelText: 'Add todo'),
          onSubmitted: (String? todoDesc) {
            if (todoDesc != null && todoDesc.trim().isNotEmpty) {
              vm.addTodo(todoDesc);
              newTodoController.clear();
            }
          },
        );
      },
    );
  }
}

class _ViewModel extends Equatable {
  final void Function(String todoDesc) addTodo;
  const _ViewModel({
    required this.addTodo,
  });

  @override
  List<Object> get props => [];

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      addTodo: (String todoDesc) => store.dispatch(
        addTodoAndDispatch(todoDesc),
      ),
    );
  }
}
