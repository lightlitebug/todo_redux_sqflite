import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/todo_model.dart';
import '../redux/app_state.dart';
import '../redux/todo_list/todo_list_action.dart';
import 'todo_item.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        final todos = vm.todos;

        return ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemCount: todos.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(color: Colors.grey);
          },
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: ValueKey(todos[index].id),
              background: showBackground(0),
              secondaryBackground: showBackground(1),
              onDismissed: (_) {
                vm.deleteTodo(todos[index].id);
              },
              confirmDismiss: (_) {
                return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('Do you really want to delete?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('NO'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('YES'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: TodoItem(todo: todos[index]),
            );
          },
        );
      },
    );
  }

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }
}

class _ViewModel extends Equatable {
  final List<Todo> todos;
  final void Function(String id) deleteTodo;
  const _ViewModel({
    required this.todos,
    required this.deleteTodo,
  });

  @override
  List<Object> get props => [todos];

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      todos: _getFilteredTodos(
        todos: store.state.todoListState.todos,
        todoFilter: store.state.todoFilterState.todoFilter,
        searchTerm: store.state.todoSearchState.searchTerm,
      ),
      deleteTodo: (String id) => store.dispatch(DeleteTodoAction(id: id)),
    );
  }

  static List<Todo> _getFilteredTodos({
    required List<Todo> todos,
    required TodoFilter todoFilter,
    required String searchTerm,
  }) {
    List<Todo> filteredTodos;

    switch (todoFilter) {
      case TodoFilter.all:
        filteredTodos = todos;
        break;
      case TodoFilter.completed:
        filteredTodos = todos.where((todo) => todo.completed).toList();
        break;
      case TodoFilter.active:
        filteredTodos = todos.where((todo) => !todo.completed).toList();
        break;
      default:
        filteredTodos = todos;
        break;
    }

    if (searchTerm.isNotEmpty) {
      filteredTodos = filteredTodos.where((Todo todo) {
        if (todo.todoDesc.toLowerCase().contains(searchTerm.toLowerCase())) {
          return true;
        }
        return false;
      }).toList();
    }

    return filteredTodos;
  }
}
