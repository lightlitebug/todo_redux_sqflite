import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/todo_model.dart';
import '../redux/app_state.dart';
import '../redux/todo_list/todo_list_action.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return ConfirmEditDialog(todo: todo);
          },
        );
      },
      leading: StoreConnector<AppState, _ToggleViewModel>(
        distinct: true,
        converter: (Store<AppState> store) => _ToggleViewModel.fromStore(store),
        builder: (BuildContext context, _ToggleViewModel vm) {
          return Checkbox(
            value: todo.completed,
            onChanged: (bool? checked) {
              vm.toggleTodo(todo.id);
            },
          );
        },
      ),
      title: Text(todo.todoDesc),
    );
  }
}

class _ToggleViewModel extends Equatable {
  final void Function(String id) toggleTodo;
  const _ToggleViewModel({
    required this.toggleTodo,
  });

  @override
  List<Object> get props => [];

  static fromStore(Store<AppState> store) {
    return _ToggleViewModel(
      toggleTodo: (String id) => store.dispatch(
        ToggleTodoAction(id: id),
      ),
    );
  }
}

class ConfirmEditDialog extends StatefulWidget {
  const ConfirmEditDialog({
    Key? key,
    required this.todo,
  }) : super(key: key);
  final Todo todo;

  @override
  State<ConfirmEditDialog> createState() => _ConfirmEditDialogState();
}

class _ConfirmEditDialogState extends State<ConfirmEditDialog> {
  late final TextEditingController textController;
  bool error = false;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.todo.todoDesc);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Todo'),
      content: TextField(
        controller: textController,
        autofocus: true,
        decoration: InputDecoration(
          errorText: error ? "Value cannot be empty" : null,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        StoreConnector<AppState, _EditViewModel>(
          distinct: true,
          converter: (Store<AppState> store) => _EditViewModel.fromStore(store),
          builder: (BuildContext context, _EditViewModel vm) {
            return TextButton(
              onPressed: () {
                error = textController.text.isEmpty ? true : false;
                if (error) {
                  setState(() {});
                } else {
                  vm.editTodo(widget.todo.id, textController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('EDIT'),
            );
          },
        ),
      ],
    );
  }
}

class _EditViewModel extends Equatable {
  final void Function(String id, String todoDesc) editTodo;
  const _EditViewModel({
    required this.editTodo,
  });

  @override
  List<Object> get props => [];

  static fromStore(Store<AppState> store) {
    return _EditViewModel(
      editTodo: (String id, String todoDesc) {
        store.dispatch(
          EditTodoAction(id: id, todoDesc: todoDesc),
        );
      },
    );
  }
}
